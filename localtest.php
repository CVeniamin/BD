<?php
    require_once './db.php'
?>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css" integrity="sha384-AysaV+vQoT3kOAXZkl02PThvDr8HYKPZhNT5h/CXfBThSRXQ6jW5DO2ekP5ViFdi" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/js/bootstrap.min.js" integrity="sha384-BLiI7JTZm+JWlgKa0M0kGRpJbF2J8q+qreVrKBC47e3K6BW78kGLrCkeRX6I9RoK" crossorigin="anonymous"></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-sm-6">
            <h1>Inserir Edificios</h1>
            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                <p>Morada: <input type="text" class="form-control" name="morada" value=""/></p>
                <p><input type="submit" class="btn btn-info" value="Inserir Edificio"/></p>
            </form>
        </div>
        <div class="col-sm-6">
            <h1>Inserir Espaços</h1>
            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                <p>Morada: <input type="text" class="form-control" name="morada_espaco" value=""/></p>
                <!--    <p>Numero: <input type="number" name="codigo_espaco" value=""/></p>-->
                <p><input type="submit" class="btn btn-info" value="Inserir Espaço"/></p>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-6">
            <?php
            $sql    = "SELECT morada FROM edificio";
            $result = $db->query($sql);
            render_view_edificio($result);
            ?>
        </div>
        <div class="col-sm-6">
            <?php
            $sql = "SELECT morada,codigo FROM espaco";
            $result_espaco = $db->query($sql);
            render_view_espaco($result_espaco);
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

try {

    if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST["morada"])) {
        $morada = test_input($_POST["morada"]);
        $stmt   = $db->prepare("INSERT INTO edificio VALUES (?)");
        $stmt->execute(array(
            $morada
        ));
        $page = $_SERVER['PHP_SELF'];
        $sec  = "2";
        header("Refresh: $sec; url=$page");
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST" && (!empty($_POST["morada_espaco"]))) {
        $morada_espaco = test_input($_POST["morada_espaco"]);
//        $codigo_espaco = test_input($_POST["codigo_espaco"]);
        $stmt   = $db->exec("CALL INSERT_ESPACO('$morada_espaco',NULL);");
//        $stmt->execute(array(
//            $morada_espaco,
//            $morada_espaco,
//        ));
        $page = $_SERVER['PHP_SELF'];
        $sec  = "2";
        header("Refresh: $sec; url=$page");
    }

    function deleteAddress($param) {
        global $db;
        $db->beginTransaction();
        if (is_array($param)){
            $stmt = $db->prepare("DELETE FROM espaco WHERE morada = ? AND codigo = ?");
            $stmt->execute(array(
                $param[0],
                $param[1],
            ));
        }else{
            $stmt = $db->prepare("DELETE FROM edificio WHERE morada = ?");
            $stmt->execute(array(
                $param
            ));

        }
        $db->commit();
        $page = $_SERVER['PHP_SELF'];
        $sec  = "2";
        header("Refresh: $sec; url=$page");
    }

    if (isset($_GET['edificio'])) {
        $param = $_GET['edificio'];
        deleteAddress($param);
    }

    if (isset($_GET['espaco']) && isset($_GET['codigo'])) {
        $param = array($_GET['espaco'],$_GET['codigo']) ;
        deleteAddress($param);
    }
    $db = null;
}

catch (PDOException $e) {
    echo ("<p>ERROR: {$e->getMessage() }</p>");
}

?>
</body>
</html>