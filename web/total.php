<?php
require_once './db.php';
ob_start();
$page = $_SERVER['PHP_SELF'];
$sec  = "3";
$param = "";
?>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css" integrity="sha384-AysaV+vQoT3kOAXZkl02PThvDr8HYKPZhNT5h/CXfBThSRXQ6jW5DO2ekP5ViFdi" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/js/bootstrap.min.js" integrity="sha384-BLiI7JTZm+JWlgKa0M0kGRpJbF2J8q+qreVrKBC47e3K6BW78kGLrCkeRX6I9RoK" crossorigin="anonymous"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

    <meta charset="utf-8">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-4">
            <a href="./../web/"><i class="fa fa-chevron-circle-left fa-3x" aria-hidden="true"></i></a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
        </div>
        <div class="col-md-4">
            <h1>Total Realizado por Edificio</h1>
            <form method="get">
                <input type="text" placeholder="Morada" class="form-control" name="edificio" value=""/>
                <br>
                <input type="submit" class="btn btn-info" value="Mostrar total"/>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
        </div>
        <div class="col-md-4">
            <?php
            $sql    = "SELECT morada FROM edificio";
            $result = $db->query($sql);
            render_view_total($result);
            ?>
        </div>

    </div>
</div>
<?php
function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
function render_view_total($result) {
    global $page;
    echo ("<table class=\"table table-striped table-hover\">\n");
    echo ("<tr><td>morada</td></tr>\n");
    foreach ($result as $row) {
        echo ("<tr><td>");
        echo ($row['morada']);
        echo ("</td>");
        echo ("<td><a href=\"{$page}?edificio={$row['morada']}\">Mostrar Total</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}
function render_view_espaco($result) {
    global $page;
    echo ("<table class=\"table table-striped table-hover\" >\n");
    echo ("<tr><td>morada</td><td>codigo</td></tr>\n");
    foreach ($result as $row) {
        echo ("<tr><td>");
        echo ($row['morada']);
        echo ("</td>");
        echo ("<td>");
        echo ($row['codigo']);
        echo ("</td>");
        echo ("<td><a href=\"{$page}?espaco={$row['morada']}&codigo={$row['codigo']}\">Remover Espaco</a></td>\n");
        echo ("<td><a href=\"{$page}?espaco_posto={$row['morada']}&codigo_espaco={$row['codigo']}\">Adicionar 
        Posto</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}
function get_total($param){
    global $db;
    global $param;
    $sql = "SELECT o.codigo,SUM(DATEDIFF(o.data_fim,o.data_inicio) * o.tarifa) AS total
                   FROM paga p LEFT JOIN aluga a ON a.numero = p.numero
                     LEFT JOIN oferta o ON o.morada = a.morada AND o.codigo = a.codigo
                   WHERE a.morada = '$param'
                   GROUP BY o.morada,o.codigo";
    $result = $db->query($sql);
    echo("<br>");
    echo("<br>");
    echo("<br>");
    echo("<div class=\"col-md-2\"></div>");
    echo("<div class=\"col-md-4\">");
    echo("<h1>Total para $param</h1>");
    echo("<table class=\"table table-striped table-hover\" >\n");
    echo("<tr><td>codigo</td><td>total</td></tr>\n");
    foreach ($result as $row) {
        echo("<tr><td>");
        echo($row['codigo']);
        echo("</td>");
        echo("<td>");
        echo(round($row['total'],2));
        echo("</td>");
    }
    echo("</div>");
    echo("</div>");
}
try {
    if (isset($_GET['edificio']) ) {
        $param = test_input($_GET['edificio']);
        get_total($param);
    }
    $db = null;
}
catch (PDOException $e) {
    echo ("<p>ERROR: {$e->getMessage() }</p>");
    header("Refresh: $sec; url=$page");
}
?>
</body>
</html>
