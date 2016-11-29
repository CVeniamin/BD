<?php
    require_once './db.php';
    ob_start();
?>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css" integrity="sha384-AysaV+vQoT3kOAXZkl02PThvDr8HYKPZhNT5h/CXfBThSRXQ6jW5DO2ekP5ViFdi" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/js/bootstrap.min.js" integrity="sha384-BLiI7JTZm+JWlgKa0M0kGRpJbF2J8q+qreVrKBC47e3K6BW78kGLrCkeRX6I9RoK" crossorigin="anonymous"></script>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-4">
            <h1>Inserir Edificios</h1>
            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                <p>Morada: <input type="text" class="form-control" name="morada" value=""/></p>
                <p><input type="submit" class="btn btn-info" value="Inserir Edificio"/></p>
            </form>
        </div>
        <div class="col-md-4">
            <h1>Inserir Espaços</h1>
            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                <p>Morada: <input type="text" class="form-control" name="morada_espaco" value=""/></p>
                <!--    <p>Numero: <input type="number" name="codigo_espaco" value=""/></p>-->
                <p><input type="submit" class="btn btn-info" value="Inserir Espaço"/></p>
            </form>
        </div>

        <div class="col-md-4">
            <h1>Inserir Postos</h1>
            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                <p>Morada: <input type="text" class="form-control" name="morada_posto" value=""/></p>
                <p>Numero Espaco: <input type="number" name="codigo_espaco" value=""/></p>
                <!--    <p>Numero: <input type="number" name="codigo_espaco" value=""/></p>-->
                <p><input type="submit" class="btn btn-info" value="Inserir Posto"/></p>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <?php
            $sql    = "SELECT morada FROM edificio";
            $result = $db->query($sql);
            render_view_edificio($result);
            ?>
        </div>
        <div class="col-md-4">
            <?php
            $sql = "SELECT morada,codigo FROM espaco";
            $result_espaco = $db->query($sql);
            render_view_espaco($result_espaco);
            ?>
        </div>
        <div class="col-md-4">
            <?php
            $sql = "SELECT morada,codigo,codigo_espaco FROM posto";
            $result_espaco = $db->query($sql);
            render_view_posto($result_espaco);
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

function render_view_edificio($result) {
    echo ("<table class=\"table table-striped\">\n");
    echo ("<tr><td>morada</td></tr>\n");

    foreach ($result as $row) {
        echo ("<tr><td>");
        echo ($row['morada']);
        echo ("</td>");
        echo ("<td><a href=\"localtest.php?edificio={$row['morada']}\">Remover Edificio</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}

function render_view_espaco($result) {
    echo ("<table class=\"table table-striped\" >\n");
    echo ("<tr><td>morada</td><td>codigo</td></tr>\n");

    foreach ($result as $row) {
        echo ("<tr><td>");
        echo ($row['morada']);
        echo ("</td>");
        echo ("<td>");
        echo ($row['codigo']);
        echo ("</td>");
        echo ("<td><a href=\"localtest.php?espaco={$row['morada']}&codigo={$row['codigo']}\">Remover Espaco</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}

function render_view_posto($result) {
    echo ("<table class=\"table table-striped\" >\n");
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
        echo ("<td><a href=\"localtest.php?posto={$row['morada']}&codigo={$row['codigo']}&codigo_espaco={$row['codigo_espaco']}\">Remover Espaco</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}
try {

    if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST["morada"])) {
        $morada = test_input($_POST["morada"]);
        $stmt   = $db->prepare("INSERT INTO edificio VALUES (?)");
        $stmt->execute(array(
            $morada
        ));
        $page = $_SERVER['PHP_SELF'];
        $sec  = "5";
        header("Refresh: $sec; url=$page");
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST" && (!empty($_POST["morada_espaco"]))) {
        $morada_espaco = test_input($_POST["morada_espaco"]);
        $stmt   = $db->exec("CALL INSERT_ESPACO('$morada_espaco',NULL);");
//        $stmt->execute(array(
//            $morada_espaco,
//            $morada_espaco,
//        ));
        $page = $_SERVER['PHP_SELF'];
        $sec  = "5";
        header("Refresh: $sec; url=$page");
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST["morada_posto"]) && !empty($_POST["codigo_espaco"])) {
        $morada_posto = test_input($_POST["morada_posto"]);
        $codigo_espaco = test_input($_POST["codigo_espaco"]);
        $stmt   = $db->exec("CALL INSERT_POSTO('$morada_posto', '$codigo_espaco', NULL);");

        $page = $_SERVER['PHP_SELF'];
        $sec  = "5";
        header("Refresh: $sec; url=$page");
    }

    function deleteAddress($param,$str) {
        global $db;
        $db->beginTransaction();
        if (strcmp($str,"edificio") == 0){
            $stmt = $db->prepare("DELETE FROM edificio WHERE morada = ?");
            $stmt->execute(array(
                $param
            ));
        }
        if (strcmp($str,"espaco") == 0){
            $stmt = $db->prepare("DELETE FROM espaco WHERE morada = ? AND codigo = ?");
            $stmt->execute(array(
                $param[0],
                $param[1],
            ));
        }
        if (strcmp($str,"posto") == 0){
            $stmt = $db->prepare("DELETE FROM posto WHERE morada = ? AND codigo = ? AND codigo_espaco = ?");
            $stmt->execute(array(
                $param[0],
                $param[1],
                $param[2]
            ));
        }
        $db->commit();

        $page = $_SERVER['PHP_SELF'];
        $sec  = "5";
        header("Refresh: $sec; url=$page");
    }

    if (isset($_GET['edificio'])) {
        $param = $_GET['edificio'];
        echo $param;
        deleteAddress($param,"edificio");
    }

    if (isset($_GET['espaco']) && isset($_GET['codigo'])) {
        $param = array(test_input($_GET['espaco']), test_input($_GET['codigo'])) ;
        deleteAddress($param,"espaco");
    }

    if (isset($_GET['posto']) && isset($_GET['codigo']) && isset($_GET['codigo_espaco'])) {
        $param = array(test_input($_GET['posto']), test_input($_GET['codigo']),test_input($_GET['codigo_espaco']));
        echo $param[2];
        deleteAddress($param,"posto");
    }

    $db = null;
}

catch (PDOException $e) {
    echo ("<p>ERROR: {$e->getMessage() }</p>");
}

?>
</body>
</html>