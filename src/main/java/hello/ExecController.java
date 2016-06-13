package hello;

import static java.util.Arrays.asList;
import static java.util.Comparator.comparing;
import static java.util.Comparator.reverseOrder;
import static java.util.stream.Collectors.toList;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by jansykora on 11.6.16.
 */
@RestController
public class ExecController {

    private final Logger logger = LoggerFactory.getLogger(ExecController.class);

    private final Connector connector;

    @Autowired
    public ExecController(Connector connector) {
        this.connector = connector;
    }

    @RequestMapping("/exec")
    public Response exec(@RequestParam(required = false) String suk, @RequestParam(required = false) String ant, @RequestParam(required = false) String conf, @RequestParam(required = false) String supp) {
        List<Connector.AsocRule> data = connector.data(new Criteria(ant, suk, conf, supp));

        return new Response(data.stream().sorted(comparing(t -> t.getConf(), reverseOrder())).collect(toList()), new Double(conf), new Double(supp));
    }

    public static class Response {
        private List<String> names;
        private Integer[][] matrix;
        private List<Connector.AsocRule> asocRules;

        public Response(List<Connector.AsocRule> list, final double minConf, final double minSupp) {
            List<String> ants = list.stream().map(a -> a.getAnt()).distinct().collect(toList());
            List<String> suks = list.stream().map(a -> a.getSuk()).distinct().collect(toList());
            List<String> combined = new ArrayList<>();
            combined.addAll(ants);
            combined.addAll(suks);
            this.names = combined.stream().distinct().collect(toList());
            this.matrix = new Integer[names.size()][names.size()];

            for (int i = 0; i < this.matrix.length; i++) {
                for (int j = 0; j < this.matrix.length; j++) {
                    if (i != j) {
                        this.matrix[i][j] = 0;
                    } else {
                        this.matrix[i][j] = 1;
                    }
                }
            }

            list.forEach(t -> {
                int indexA = names.indexOf(t.getAnt());
                int indexB = names.indexOf(t.getSuk());
                if (minConf <= t.getConf() && minSupp <= t.getSupp()) {
                    this.matrix[indexA][indexB] = 1;
                    this.matrix[indexA][indexA] = 0;
                }
            });

            this.asocRules = list;
        }

        public List<Connector.AsocRule> getAsocRules() {
            return asocRules;
        }

        public void setAsocRules(List<Connector.AsocRule> asocRules) {
            this.asocRules = asocRules;
        }

        public List<String> getNames() {
            return names;
        }

        public void setNames(List<String> names) {
            this.names = names;
        }

        public Integer[][] getMatrix() {
            return matrix;
        }

        public void setMatrix(Integer[][] matrix) {
            this.matrix = matrix;
        }
    }

    public static class Criteria {
        private String ant;
        private String suk;
        private String conf;
        private String support;

        public Criteria(String ant, String suk, String conf, String support) {
            this.ant = ant;
            this.suk = suk;
            this.conf = conf;
            this.support = support;
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

        public String getConf() {
            return conf;
        }

        public void setConf(String conf) {
            this.conf = conf;
        }

        public String getSupport() {
            return support;
        }

        public void setSupport(String support) {
            this.support = support;
        }

        @Override
        public String toString() {
            return "Criteria{" +
                    "ant='" + ant + '\'' +
                    ", suk='" + suk + '\'' +
                    ", conf='" + conf + '\'' +
                    ", support='" + support + '\'' +
                    '}';
        }
    }
}
