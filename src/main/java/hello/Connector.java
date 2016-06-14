package hello;

import static org.springframework.util.StringUtils.isEmpty;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

/**
 * Created by jansykora on 11.6.16.
 */
@Service
public class Connector {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public Connector(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<AsocRule> data(ExecController.Criteria criteria) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * FROM asoc_rules as a WHERE");
        boolean ant = append(sb, "ant", criteria.getAnt(), false);
        boolean suk = append(sb, "suk", criteria.getSuk(), ant);
        boolean conf = appendConf(sb, criteria.getConf(), suk);
        boolean supp = appendSupp(sb, criteria.getSupport(), conf);
        String sql = sb.toString();
        return jdbcTemplate.query(
                sql,
                new Object[]{},
                (rs, i) ->
                        new AsocRule(rs.getString("ant"), rs.getString("suk"), rs.getLong("a"), rs.getLong("b"), rs.getLong("c"), rs.getLong("d"))
        );
    }

    private boolean append(StringBuilder sb, String attr, String s, boolean and) {
        if (isEmpty(s) || s.split("\\$")[0].contains("UNDEF") || s.split("\\$")[0].contains("undefined")) {
            return and || false;
        }
        if (and) sb.append(" AND");
        if( s.split("\\$")[1].contains("undefined")) {
            sb.append(" a."+attr +" LIKE ('"+s.split("\\$")[0]+"%')");
            return true;
        }
        sb.append(" a." + attr + "='" + s + "'");
        return true;
    }

    private boolean appendConf(StringBuilder sb, String s, boolean and) {
        if (isEmpty(s) || s.contains("undefined")) {
            return and || false;
        }
        if (and) sb.append(" AND");
        sb.append(" (a.a/(a.a + a.b) >= " + s + ")");
        return true;
    }

    private boolean appendSupp(StringBuilder sb, String s, boolean and) {
        if (isEmpty(s) || s.contains("undefined")) {
            return and || false;
        }
        if (and) sb.append(" AND");

        sb.append(" (a.a/(a.a + a.b + a.c + a.d) >= " + s + ")");
        return true;
    }

    public static class AsocRule {
        private String ant;
        private String suk;
        private Long a;
        private Long b;
        private Long c;
        private Long d;
        private double conf;
        private double supp;

        public AsocRule(String ant, String suk, Long a, Long b, Long c, Long d) {
            this.ant = ant;
            this.suk = suk;
            this.a = a;
            this.b = b;
            this.c = c;
            this.d = d;
            this.conf = calculateConf();
            this.supp = calculateSupp();
        }


        public double getConf() {
            return conf;
        }

        public void setConf(double conf) {
            this.conf = conf;
        }

        public double getSupp() {
            return supp;
        }

        public void setSupp(double supp) {
            this.supp = supp;
        }

        public String getAnt() {
            return ant;
        }

        public void setAnt(String ant) {
            this.ant = ant;
        }

        public String getSuk() {
            return suk;
        }

        public void setSuk(String suk) {
            this.suk = suk;
        }

        public Long getA() {
            return a;
        }

        public void setA(Long a) {
            this.a = a;
        }

        public Long getB() {
            return b;
        }

        public void setB(Long b) {
            this.b = b;
        }

        public Long getC() {
            return c;
        }

        public void setC(Long c) {
            this.c = c;
        }

        public Long getD() {
            return d;
        }

        public void setD(Long d) {
            this.d = d;
        }

        private double calculateConf() {
            double a = getA();
            double b = getB();
            return (a / (a + b));
        }

        private double calculateSupp() {
            double a = getA();
            double b = getB();
            double c = getC();
            double d = getD();
            return (a / (a + b + c + d));
        }


        @Override
        public String toString() {
            return "AsocRule{" +
                    "ant='" + ant + '\'' +
                    ", suk='" + suk + '\'' +
                    ", a=" + a +
                    ", b=" + b +
                    ", c=" + c +
                    ", d=" + d +
                    '}';
        }
    }
}
