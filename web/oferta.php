<?php
require_once './db.php';
ob_start();

$page = $_SERVER['PHP_SELF'];
$sec  = "3";

$show_modal = false;

?>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.1.1.slim.js" integrity="sha256-5i/mQ300M779N2OVDrl16lbohwXNUdzL/R2aVUXyXWA=" crossorigin="anonymous"></script>
<!--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>-->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.standalone.css"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/locales/bootstrap-datepicker.en-GB.min.js"></script>
<!--    <meta charset="iso-8859-1">-->
    <meta charset="utf-8">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-3">
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
                                <input type="text" placeholder="Data Inicio"  name="data_inicio" class="form-control">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                            </div>
                            <br>
                            <div class="input-group date">
                                <input type="text" placeholder="Data Fim" name="data_fim" class="form-control" value="">
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
        <div class="col-md-5">
            <h1>Todas as Ofertas</h1>
            <?php
                $sql = "SELECT morada,codigo,data_inicio,data_fim,tarifa FROM oferta";
                $result_espaco = $db->query($sql);
                render_view_oferta($result_espaco);
            ?>
        </div>

        <div class="col-md-3">
                <div class="row">
                    <div class="col-md-12">
                        <h1>Criar Reservas</h1>
                        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                            <input type="text" placeholder="Morada" class="form-control" name="morada_reserva" value="<?php echo(
                            isset($_GET['espaco_aluga']) ?  htmlspecialchars($_GET['espaco_aluga']) : '')?>"/>
                            <br>
                            <input type="text" placeholder="Codigo" class="form-control" name="codigo_reserva" value="<?php echo(
                            isset($_GET['codigo_aluga']) ?  htmlspecialchars($_GET['codigo_aluga']) : '')?>"/>
                            <br>
                            <input type="text" placeholder="Data Inicio" class="form-control" name="data_inicio_reserva"
                                   value="<?php echo(isset($_GET['data_inicio_aluga']) ?  htmlspecialchars($_GET['data_inicio_aluga']) : '')?>"/>
                            <br>
                            <?php
                                $sql = "SELECT nif FROM user";
                                $result_user = $db->query($sql);
                                echo(" <select class=\"form-control\" name=\"nif\">");
                                echo("<option value=\" \" >User NIF</option>");
                                foreach ($result_user as $user){
                                    echo("<option value=\"{$user["nif"]}\">{$user["nif"]} </option>");
                                }
                                echo("</select>");
                            ?>
<!--                            <input type="text" placeholder="NIF" class="form-control" name="nif" value=""/>-->
                            <br>
                            <input type="submit" class="btn btn-info" value="Inserir Reserva"/>
                        </form>
                    </div>
                    <div class="col-md-12">
                        <h1>Todas as Reservas</h1>
                        <?php
                        $sql = "SELECT  numero FROM reserva";
                        $result_espaco = $db->query($sql);
                        render_view_reserva($result_espaco);
                        ?>
                    </div>
                </div>
            </div>
    </div>
    <div class="row">
        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Metodo de Pagamento</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <form  action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post" >
                            <input type="text" placeholder="Morada" class="form-control" name="reserva_paga"
                                   value="<?php echo(isset($_GET['reserva']) ?  htmlspecialchars($_GET['reserva']) : '')?>"/>
                            <br>
                            <label>Escolhe um metodo:</label>
                            <select class="form-control" name="pagamento">
                                <option value="Cartão Crédito">Cartão Crédito</option>
                                <option value="Paypal">Paypal</option>
                            </select>
                            <br>
                            <input type="submit" class="btn btn-info" value="Pagar"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
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
        echo ("<td><a href=\"{$page}?espaco_aluga={$row['morada']}&codigo_aluga={$row['codigo']}&data_inicio_aluga={$row['data_inicio']}\">Reservar</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}

function render_view_reserva($result) {
    global $page;

    echo ("<table class=\"table table-striped table-hover\" >\n");
    echo ("<tr><td>numero</td></tr>\n");
    foreach ($result as $row) {
        echo ("<tr><td>");
        echo ($row['numero']);
        echo ("</td>");
        echo ("<td><a href=\"{$page}?reserva={$row['numero']}\">Pagar Reserva</a></td>\n");
        echo ("</tr>\n");
    }
    echo ("</table>\n");
}

function pagar($param){
    global $db;
    $db->beginTransaction();
    $stmt = $db->prepare("INSERT INTO paga VALUES (?,?,?)");
    $stmt->execute($param);
    $db->commit();

}

function reservar($param){

    global $db;
    $db->beginTransaction();
    $sth = $db->prepare("SELECT numero FROM reserva");
    $sth->execute();
    $result = $sth->fetchAll(PDO::FETCH_COLUMN, 0);
    $db->commit();
    $tmp_arr = 0;
    foreach ($result as $res){
        $arr = explode("-",$res);
        if ($arr[1] >= $tmp_arr){
            $tmp_arr = $arr[1];
        }
    }

    $tmp_arr = $tmp_arr + 1;
    $tmp = $param[2];
    $tmp = explode("-",$tmp);
    $tmp = array($tmp[0],$tmp_arr);
    $tmp = implode("-",$tmp);

    $db->beginTransaction();
    $stmt = $db->prepare("CALL INSERT_ALUGA(?,?,?,?,?);");
    array_push($param,$tmp);

    $stmt->execute(array(
        $param[0],
        $param[1],
        $param[2],
        $param[3],
        $param[4],
    ));

    $db->commit();


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

    if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST["nif"]) && !empty($_POST["data_inicio_reserva"])
        && !empty($_POST["morada_reserva"]) && !empty($_POST["codigo_reserva"])) {
        $morada = test_input($_POST["morada_reserva"]);
        $codigo = test_input($_POST["codigo_reserva"]);
        $data_inicio = test_input($_POST["data_inicio_reserva"]);
        $nif = test_input($_POST["nif"]);

        reservar(array($morada,$codigo,$data_inicio,$nif));

        header("Refresh: $sec; url=$page");
    }

    if (isset($_GET['espaco']) && isset($_GET['codigo']) && isset($_GET['data_inicio'])) {
        $param = array(test_input($_GET['espaco']), test_input($_GET['codigo']),test_input($_GET['data_inicio']));
        deleteAddress($param,"oferta");

        header("Refresh: $sec; url=$page");

    }



    if ( $_SERVER["REQUEST_METHOD"] == "GET" && !empty($_GET['reserva'])) {
        $show_modal = true;
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST" && !empty($_POST["pagamento"]) && !empty($_POST["reserva_paga"])) {
        $reserva = test_input($_POST['reserva_paga']);
        $pagamento = utf8_decode(test_input($_POST['pagamento']));
        echo $pagamento;
        $today = date("Y-m-d H:i:s");
        $param = array($reserva,$today,$pagamento);
        pagar($param);
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

<?php if($show_modal):?>
    <script type="application/javascript"> $('#myModal').modal('show');</script>
<?php endif;?>

</body>
</html>
