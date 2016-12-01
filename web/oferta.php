<?php
require_once './db.php';
ob_start();

$page = $_SERVER['PHP_SELF'];
$sec  = "3";
?>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.1.1.slim.js" integrity="sha256-5i/mQ300M779N2OVDrl16lbohwXNUdzL/R2aVUXyXWA=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.standalone.css"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/locales/bootstrap-datepicker.en-GB.min.js"></script>
    <meta charset="utf-8">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <h1>Criar Ofertas</h1>
                    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                        <input type="text" placeholder="Morada" class="form-control" name="morada" value="<?php echo(
                        isset($_GET['morada']) ?  htmlspecialchars($_GET['morada']) : '')?>"/>
                        <br>
                        <input type="text" placeholder="Codigo" class="form-control" name="codigo" value="<?php echo(
                        isset($_GET['codigo']) ?  htmlspecialchars($_GET['codigo']) : '')?>"/>
                        <br>
                        <div id="sandbox-container">
                            <div class="input-group date">
                                <input type="text" placeholder="data inicio"  name="data_inicio" class="form-control">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                            </div>
                            <br>
                            <div class="input-group date">
                                <input type="text" placeholder="data fim" name="data_fim" class="form-control" value="">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                            </div>
                        </div>
                        <br>
                        <input type="number" placeholder="Tarifa" min="0" class="form-control" name="tarifa" value=""/>
                        <br>
                        <input type="submit" class="btn btn-info" value="Inserir Edificio"/>
                    </form>
                </div>
                <div class="col-md-12">
                    <h1>Todos os alugaveis</h1>
                    <?php
                    $sql    = "SELECT morada,codigo FROM alugavel";
                    $result = $db->query($sql);
                    render_view_alugavel($result);
                    ?>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <h1>Todas as Ofertas</h1>
            <?php
                $sql = "SELECT morada,codigo,data_inicio,data_fim,tarifa FROM oferta";
                $result_espaco = $db->query($sql);
                render_view_oferta($result_espaco);
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

function render_view_alugavel($result) {
    global $page;
    echo ("<table class=\"table table-striped table-hover\">\n");
    echo ("<tr><td>morada</td><td>codigo</td></tr>\n");

    foreach ($result as $row) {
        echo ("<tr><td>");
        echo ($row['morada']);
        echo ("</td><td>");
        echo ($row['codigo']);
        echo ("</td>");
        echo ("<td><a href=\"{$page}?morada={$row['morada']}&codigo={$row['codigo']}\">Criar oferta</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}

function render_view_oferta($result) {
    global $page;
    echo ("<table class=\"table table-striped table-hover\" >\n");
    echo ("<tr><td>morada</td><td>codigo</td><td>data_inicio</td><td>data_fim</td><td>tarifa</td></tr>\n");
    foreach ($result as $row) {
        echo ("<tr><td>");
        echo ($row['morada']);
        echo ("</td>");
        echo ("<td>");
        echo ($row['codigo']);
        echo ("</td>");
        echo ("<td>");
        echo ($row['data_inicio']);
        echo ("</td>");
        echo ("<td>");
        echo ($row['data_fim']);
        echo ("</td>");
        echo ("<td>");
        echo ($row['tarifa']);
        echo ("</td>");
        echo ("<td><a href=\"{$page}?espaco={$row['morada']}&codigo={$row['codigo']}&data_inicio={$row['data_inicio']}\">Remover Oferta</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}

function render_view_posto($result) {
    global $page;
    echo ("<table class=\"table table-striped table-hover\" >\n");
    echo ("<tr><td>morada</td><td>codigo</td><td>codigo_espaco</td></tr>\n");

    foreach ($result as $row) {
        echo ("<tr><td>");
        echo ($row['morada']);
        echo ("</td>");
        echo ("<td>");
        echo ($row['codigo']);
        echo ("</td>");
        echo ("<td>");
        echo ($row['codigo_espaco']);
        echo ("</td>");
        echo ("<td><a href=\"{$page}?posto={$row['morada']}&codigo={$row['codigo']}&codigo_espaco={$row
        ['codigo_espaco']}\">Remover Posto</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}
try {
    if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST["tarifa"]) && !empty($_POST["data_inicio"]) &&
        !empty($_POST["data_fim"]) && !empty($_POST["morada"]) && !empty($_POST["codigo"])) {
        $morada = test_input($_POST["morada"]);
        $codigo = test_input($_POST["codigo"]);
        $data_inicio = test_input($_POST["data_inicio"]);
        $data_fim = test_input($_POST["data_fim"]);
        $tarifa = test_input($_POST["tarifa"]);

        $stmt   = $db->prepare("INSERT INTO oferta VALUES (?,?,?,?,?)");
        $stmt->execute(array(
            $morada,
            $codigo,
            $data_inicio,
            $data_fim,
            $tarifa
        ));
        header("Refresh: $sec; url=$page");
    }
    if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST["morada_posto"]) && !empty($_POST["codigo_posto"]) &&
        !empty($_POST["foto_url_posto"]) && !empty($_POST["codigo_espaco"])) {
        $morada_posto = test_input($_POST["morada_posto"]);
        $codigo_posto = test_input($_POST["codigo_posto"]);
        $foto_url_posto = test_input($_POST["foto_url_posto"]);
        $codigo_espaco = test_input($_POST["codigo_espaco"]);
        $stmt = $db->prepare("CALL INSERT_POSTO(?,?,?,?)");
        $stmt->execute(array(
            $morada_posto,
            $codigo_posto,
            $codigo_espaco,
            $foto_url_posto
        ));
//        $stmt   = $db->exec("CALL INSERT_POSTO('$morada_posto', '$codigo_posto', NULL);");
        header("Refresh: $sec; url=$page");
    }

    function deleteAddress($param,$str) {
        global $db;
        $db->beginTransaction();

        if (strcmp($str,"oferta") == 0){
            $stmt = $db->prepare("DELETE FROM oferta WHERE morada = ? AND codigo = ? AND data_inicio = ?");
            $stmt->execute(array(
                $param[0],
                $param[1],
                $param[2]
            ));
        }
        $db->commit();

        $page = $_SERVER['PHP_SELF'];
        $sec  = "3";
        header("Refresh: $sec; url=$page");
    }

    if (isset($_GET['espaco']) && isset($_GET['codigo']) && isset($_GET['data_inicio'])) {
        $param = array(test_input($_GET['espaco']), test_input($_GET['codigo']),test_input($_GET['data_inicio']));
        deleteAddress($param,"oferta");
    }

    $db = null;
}

catch (PDOException $e) {
    echo ("<p>ERROR: {$e->getMessage() }</p>");
}

?>

<script type="application/javascript">
    $('#sandbox-container .input-group.date').datepicker({
        format: "yyyy/mm/dd",
        maxViewMode: 3,
        clearBtn: true
    });
</script>
</body>
</html>
