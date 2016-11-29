<html>
<body>
<h1>Inserir Edificios</h1>
<form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
  <p>Morada <input type="text" name="morada" value=""/>
  </p>
  <p><input type="submit" value="Inserir"/></p>
</form>

<?php

require_once './dbconfig.php';
//$host= "localhost";
//$user = "root";
//$password="";
//$dbname = "test";

function test_input($data)
{
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
function render_view($result)
{
  echo ("<table border=\"1\">\n");
  echo ("<tr><td>morada</td></tr>\n");

  foreach ($result as $row) {
    echo ("<tr><td>");
    echo ($row['morada']);
    echo ("</td>");
    echo ("<td><a href=\"localtest.php?id={$row['morada']}\">Remover Morada</a></td>\n");
    echo ("</tr>\n");
  }
  echo ("</table>\n");
}
try {
  $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
  $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  $sql    = "SELECT morada FROM edificio;";
  $result = $db->query($sql);
  render_view($result);

  if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $morada = test_input($_POST["morada"]);

    $stmt = $db->prepare("INSERT INTO edificio VALUES (?)");
    $stmt->execute(array(
        $morada
    ));
    echo ("<p>$sql</p>");

    $page = $_SERVER['PHP_SELF'];
    $sec  = "2";
    header("Refresh: $sec; url=$page");
  }
  function deleteAddress($param)
  {
    global $db;
    $db->beginTransaction();
    $stmt = $db->prepare("DELETE FROM edificio WHERE morada = ?");
    $stmt->execute(array(
        $param
    ));
    $db->commit();
    $page = $_SERVER['PHP_SELF'];
    $sec  = "2";
    header("Refresh: $sec; url=$page");
  }
  if (isset($_GET['id'])) {
    $param = $_GET['id'];
    deleteAddress($param);
  }
  $db = null;
}
catch (PDOException $e) {
  echo ("<p>ERROR: {$e->getMessage()}</p>");
}
?>
</body>
</html>
