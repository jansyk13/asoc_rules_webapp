<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="en">


<head>
    <meta>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <script
            src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
            crossorigin="anonymous"></script>
    <script src="js/d3.min.js"></script>
    <script src="js/d3.dependencyWheel.js"></script>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans&subset=latin,latin-ext' rel='stylesheet'
          type='text/css'>

    </meta>

    <style>
        body {
            font-family: "Open Sans"
        }

        .dependencyWheel {
            position: relative;
            width: 100%;
        }

        .dependencyWheel > g {
            transform: translate(50%, 50%);
        }

        .legenda {
            height: 30px;
            width: 30px;
            line-height: 30px;

            -moz-border-radius: 30px; /* or 50% */
            border-radius: 30px; /* or 50% */

            text-align: center;
            font-size: 2em;
        }

        /*------------------------------------*\
	    LISTS
        \*------------------------------------*/
        ul {
            width: 760px;
            margin-bottom: 20px;
        }

        li {
            float: left;
            display: inline;
        }

        li > span {
            display: inline-block;
            vertical-align: top;
            margin-right: 10px;
            margin-bottom: 10px;
            font-size: 20px;
        }

        .expl-row {
            font-size: 20px;
            margin: 10px;
        }

        .main-select {
            width: 41%;
        }

        .main-select2 {
            width: 45%;
        }

        .container {
            width: 85%;
        }

        .no-data{
            width: 60%;
            margin: 0px auto;
            font-size: 20px;
        }
    </style>
</head>

<body>
<div class="container">

    <!-- Static navbar -->
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <h1>Asociační pravidla na datasetu od Dáme Jídlo</h1>
                <a href="http://sorry.vse.cz/~berka/docs/izi456/kap_5.2.pdf">Odkaz na teorii</a>
            </div>
        </div><!--/.container-fluid -->
    </nav>

    <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <div class="row">
            <div class="col-md-6">
                <label>Předpoklad </label>
                <select class="any-action ant-action-dim main-select" id="ant_dim">
                    <option value="UNDEF" selected>Vše</option>
                    <option value="o_delivery_price">Cena rozvozu objednávky</option>
                    <option value="o_total_price">Celková cena objednávky</option>
                    <option value="o_payed_by_label">Typ platby</option>
                    <option value="o_origin_label">Původ objednávky</option>
                    <option value="o_distance_a">Vzdálenost rozvozu</option>
                    <option value="o_first_order">První objednávka</option>
                    <option value="o_delivery_type">Typ rozvozu</option>
                    <option value="o_traffic_source_id">Zdroj objednávky</option>
                    <option value="o_dayssincepreviousorder">Dny od poslední objednávky</option>
                    <option value="o_city">Destinace objednávky</option>
                    <option value="r_city">Lokace restaurace</option>
                    <option value="r_district">Čtvrť restaurace</option>
                    <option value="r_exclusive">Exkluzivnost restaurace</option>
                    <option value="r_min_order_price">Min. cena objednávky restaurace</option>
                    <option value="r_min_delivery_time">Cena rozvozu restaurace</option>
                </select>
                <select class="any-action ant-action-val main-select" id="ant_val">
                </select>
            </div>
            <div class="col-md-6">
                <label>Závěr</label>
                <select class="any-action suk-action-dim main-select2" id="suk_dim">
                    <option value="UNDEF" selected>Vše</option>
                    <option value="o_delivery_price">Cena rozvozu objednávky</option>
                    <option value="o_total_price">Celková cena objednávky</option>
                    <option value="o_payed_by_label">Typ platby</option>
                    <option value="o_origin_label">Původ objednávky</option>
                    <option value="o_distance_a">Vzdálenost rozvozu</option>
                    <option value="o_first_order">První objednávka</option>
                    <option value="o_delivery_type">Typ rozvozu</option>
                    <option value="o_traffic_source_id">Zdroj objednávky</option>
                    <option value="o_dayssincepreviousorder">Dny od poslední objednávky</option>
                    <option value="o_city">Destinace objednávky</option>
                    <option value="r_city">Lokace restaurace</option>
                    <option value="r_district">Čtvrť restaurace</option>
                    <option value="r_exclusive">Exkluzivnost restaurace</option>
                    <option value="r_min_order_price">Min. cena objednávky restaurace</option>
                    <option value="r_min_delivery_time">Cena rozvozu restaurace</option>
                </select>
                <select class="any-action suk-action-val main-select2" id="suk_val">
                </select>
            </div>
        </div>
        <div class="row" style="margin-top: 10px">
            <div class="col-md-6">
                <label>Platí alespoň z (Spolehlivost):</label>
                <select class="any-action conf-action">
                    <option value="0.99">99%</option>
                    <option value="0.95">95%</option>
                    <option value="0.90">90%</option>
                    <option value="0.85" selected>85%</option>
                    <option value="0.80">80%</option>
                    <option value="0.75">75%</option>
                    <option value="0.70">70%</option>
                    <option value="0.60">60%</option>
                    <option value="0.50">50%</option>
                    <option value="0.30">30%</option>
                    <option value="0.10">10%</option>
                </select>
            </div>
            <div class="col-md-6">
                <label>Platí alespoň pro (Podpora):</label>
                <select class="any-action supp-action">
                    <option value="0.01">1%</option>
                    <option value="0.02">2%</option>
                    <option value="0.03">3%</option>
                    <option value="0.04">4%</option>
                    <option value="0.05" selected>5%</option>
                    <option value="0.10">10%</option>
                    <option value="0.25">25%</option>
                    <option value="0.50">50%</option>
                    <option value="0.75">75%</option>
                </select>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-xs-8">
                <div id="chart_placeholder">

                </div>
            </div>
            <div class="col-xs-4">
                <h3>Legenda</h3>
                <div class="row" id="legend">
                </div>
            </div>
        </div>
        <hr>
        <h3>Nalezená pravidla</h3>
        <ol class="row" id="rules">
        </ol>
    </div>

</div>

<script>
    $(document).ready(function () {
        $('.any-action').change(function () {
            var ant_dim, ant_val, suk_dim, suk_val, conf, supp;
            ant_dim = $('.ant-action-dim').val();
            ant_val = $('.ant-action-val').val();
            suk_dim = $('.suk-action-dim').val();
            suk_val = $('.suk-action-val').val();
            conf = $('.conf-action').val();
            supp = $('.supp-action').val();
            var params = '?ant=' + ant_dim + "$" + ant_val + '&suk=' + suk_dim + "$" + suk_val + '&conf=' + conf + '&supp=' + supp;
            var urlExecNames = 'exec' + params;
            $.get(urlExecNames, function (data) {
                console.log(data);
                if (data.names.length == 0) {
                    var $rules = $('#rules');
                    $rules.text('');
                    $('#legend').html('<ul id="triple" style="width: 100%"></ul>');
                    $('#chart_placeholder > *').remove();

                    $('#chart_placeholder').html("<div class='no-data'>Nenalezena žádná pravidla nebo nejsou data.</div>")
                    return;
                }
                var data2 = {
                    packageNames: data.names,
                    matrix: data.matrix
                }
                redraw(data2);
                expl(data.asocRules);
            });
        })

        $('#ant_dim').trigger('change');
        $('#suk_dim').trigger('change');

        $('.supp-action').trigger('change');
    });

    function redraw(data) {
        $('#legend').html('<ul id="triple" style="width: 100%"></ul id="triple" >');
        $('#chart_placeholder > *').remove();

        var chart = d3.chart.dependencyWheel()
                .width(700)    // also used for height, since the wheel is in a a square
                .margin(200)   // used to display package names
                .padding(.02);
        d3.select('#chart_placeholder')
                .datum(data)
                .call(chart);
    }

    function expl(asocRules) {
        var $rules = $('#rules');
        $rules.text('');

        $.map(asocRules, function (rule, i) {
            var $row = $('<div></div>').addClass("row").addClass("expl-row").text('Antecedent=' + rule.ant + ' => Sukcedent=' + rule.suk + ' Spolehlivost=' + (rule.conf * 100).toString().substring(0, 4) + '% Podpora=' + (rule.supp * 100).toString().substring(0, 4) + '%');
            $rules.append($row);
        });
    }

    var combs = {
        'o_delivery_price': ['UNDEF_0', '1_50', '51_100', '101_150', '151_UNDEF'],
        'o_total_price': ['0_150', '151_300', '301_450', '451_UNDEF'],
        'o_payed_by_label': ['Cash', 'Credit_Card'],
        'o_origin_label': ['App', 'Web'],
        'o_distance_a': ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
        'o_first_order': ['0', '1'],
        'o_delivery_type': ['courier', 'external', 'takeway', 'restaurant'],
        'o_traffic_source_id': ['(direct)-(direct)-(not_set)', 'google-organic-(not_set)', 'app-app-', 'mpi.gpwebpay.com-referral-',
            'adwords-cpc-brand', 'adwords-cpc-non-brand', 'facebook.com-referral-', 'seznam-organic-(not_set)', 'sklik-cpc-non-brand',
            '3dsecure.gpwebpay.com-referral', 'facebook-organic-', 'cj-affil-cj_3753807', 'redir.netcentrum.cz-referral-'],
        'o_dayssincepreviousorder': ['0_5', '6_10', '11_30', '31_100', '101_UNDEF'],
        'o_city': ['Praha', 'Brno', 'Liberec', 'Ostrava', 'Hradec_Králové', 'Olomouc', 'Plzeň', 'České_Budějovice', 'Pardubice', 'Ústí_nad_Labem', 'Zlín',
            'Frýdek-Místek', 'Opava', 'Chomutov', 'Mladá_Boleslav'],
        'r_city': ['Praha', 'Brno', 'Ostrava', 'Plzeň', 'Liberec', 'Pardubice', 'Hradec_Králové', 'Olomouc', 'České_Budějovice', 'Ústí_nad_Labem', 'Zlín',
            'Teplice', 'Karlovy_Vary', 'Mladá_Boleslav', 'Others'],
        'r_district': ['Praha', 'Praha_1', 'Praha_10', 'Praha_11', 'Praha_12', 'Praha_13', 'Praha_14', 'Praha_15', 'Praha_16', 'Praha_17', 'Praha_18', 'Praha_19',
            'Praha_2', 'Praha_20', 'Praha_21', 'Praha_22', 'Praha_3', 'Praha_4', 'Praha_5', 'Praha_6', 'Praha_7', 'Praha_8', 'Praha_9', 'Praha-Běchovice',
            'Praha-Březiněves', 'Praha-Čakovice', 'Praha-Ďáblice', 'Praha-Dolní_Chabry', 'Praha-Dolní_Měcholupy', 'Praha-Dolní_Počernice', 'Praha-Dubeč',
            'Praha-Klánovice', 'Praha-Kolovraty', 'Praha-Kunratice', 'Praha-Libuš', 'Praha-Lipence', 'Praha-Lysolaje', 'Praha-Petrovice', 'Praha-Řeporyje',
            'Praha-Suchdol', 'Praha-Šeberov', 'Praha-Štěrboholy', 'Praha-Troja', 'Praha-Velká_Chuchle', 'Praha-Zbraslav', 'Praha-Zličín'],
        'r_exclusive': ['0', '1'],
        'r_min_order_price': ['UNDEF_0', '1_50', '51_100', '101_150', '151_200', '201_250', '251_UNDEF'],
        'r_min_delivery_time': ['UNDEF_30', '31_60', '61_90', '91_UNDEF']
    }

    var translations = {
        'o_delivery_price': {
            'cs':'Cena rozvozu objednávky',
            'inner': {
                'platform': ['UNDEF_0', '1_50', '51_100', '101_150', '151_UNDEF'],
                'cs': ['0', '1 až 50', '51 až 100', '101 až 150', '151 a více']
            }
        },
        'o_total_price': {
            'cs': 'Celková cena objednávky',
            'inner': {
                'platform': ['0_150', '151_300', '301_450', '451_UNDEF'],
                'cs': ['0 až 150', '151 až 300', '301 až 450', '451 a více']
            }
        },
        'o_payed_by_label': ['Cash', 'Credit_Card'],
        'o_origin_label': ['App', 'Web'],
        'o_distance_a': ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
        'o_first_order': ['0', '1'],
        'o_delivery_type': ['courier', 'external', 'takeway', 'restaurant'],
        'o_traffic_source_id': ['(direct)-(direct)-(not_set)', 'google-organic-(not_set)', 'app-app-', 'mpi.gpwebpay.com-referral-',
            'adwords-cpc-brand', 'adwords-cpc-non-brand', 'facebook.com-referral-', 'seznam-organic-(not_set)', 'sklik-cpc-non-brand',
            '3dsecure.gpwebpay.com-referral', 'facebook-organic-', 'cj-affil-cj_3753807', 'redir.netcentrum.cz-referral-'],
        'o_dayssincepreviousorder': ['0_5', '6_10', '11_30', '31_100', '101_UNDEF'],
        'o_city': ['Praha', 'Brno', 'Liberec', 'Ostrava', 'Hradec_Králové', 'Olomouc', 'Plzeň', 'České_Budějovice', 'Pardubice', 'Ústí_nad_Labem', 'Zlín',
            'Frýdek-Místek', 'Opava', 'Chomutov', 'Mladá_Boleslav'],
        'r_city': ['Praha', 'Brno', 'Ostrava', 'Plzeň', 'Liberec', 'Pardubice', 'Hradec_Králové', 'Olomouc', 'České_Budějovice', 'Ústí_nad_Labem', 'Zlín',
            'Teplice', 'Karlovy_Vary', 'Mladá_Boleslav', 'Others'],
        'r_district': ['Praha', 'Praha_1', 'Praha_10', 'Praha_11', 'Praha_12', 'Praha_13', 'Praha_14', 'Praha_15', 'Praha_16', 'Praha_17', 'Praha_18', 'Praha_19',
            'Praha_2', 'Praha_20', 'Praha_21', 'Praha_22', 'Praha_3', 'Praha_4', 'Praha_5', 'Praha_6', 'Praha_7', 'Praha_8', 'Praha_9', 'Praha-Běchovice',
            'Praha-Březiněves', 'Praha-Čakovice', 'Praha-Ďáblice', 'Praha-Dolní_Chabry', 'Praha-Dolní_Měcholupy', 'Praha-Dolní_Počernice', 'Praha-Dubeč',
            'Praha-Klánovice', 'Praha-Kolovraty', 'Praha-Kunratice', 'Praha-Libuš', 'Praha-Lipence', 'Praha-Lysolaje', 'Praha-Petrovice', 'Praha-Řeporyje',
            'Praha-Suchdol', 'Praha-Šeberov', 'Praha-Štěrboholy', 'Praha-Troja', 'Praha-Velká_Chuchle', 'Praha-Zbraslav', 'Praha-Zličín'],
        'r_exclusive': ['0', '1'],
        'r_min_order_price': ['UNDEF_0', '1_50', '51_100', '101_150', '151_200', '201_250', '251_UNDEF'],
        'r_min_delivery_time': ['UNDEF_30', '31_60', '61_90', '91_UNDEF']
    }

    var $ant_val = $('#ant_val');
    $('#ant_dim').change(function () {
        var dim = $(this).val(), lcns = combs[dim] || [];

        var html = $.map(lcns, function (lcn) {
            return '<option value="' + lcn + '">' + lcn + '</option>'
        }).join('');
        $ant_val.html("<option value='undefined' selected></option>"+html)
    });

    var $suk_val = $('#suk_val');
    $('#suk_dim').change(function () {
        var dim = $(this).val(), lcns = combs[dim] || [];

        var html = $.map(lcns, function (lcn) {
            return '<option value="' + lcn + '">' + lcn + '</option>'
        }).join('');
        $suk_val.html("<option value='undefined' selected></option>"+html)
    });


</script>
</body>

</html>
