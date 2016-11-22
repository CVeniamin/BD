<?php
  require_once 'dbconfig.php';

try {
  $conn= new PDO("mysql:host=$host;dbname=$dbname", $username,$password);
} catch (PDOException $pe) {
  die("Couldn't Connected to the database $dbname:".$pe->getMessage());
}
echo("<p>Connected to MySQL database $dbname on $host</p>");

$sql = "SELECT * FROM account";



echo('<form method="post" action="' . htmlspecialchars($_SERVER["PHP_SELF"]) . ' >');

echo('<input type="text" name="customer" value="' . htmlspecialchars($_POST["customer"]) . ' />');

echo('<input type="submit" name="submit" /> </form>');


if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["customer"])) {
    echo "empty";
  } else {
    $name = test_input($_POST["customer"]);
    // check if name only contains letters and whitespace
    if (!preg_match("/^[a-zA-Z ]*$/",$name)) {
      $nameErr = "Only letters and white space allowed";
    }
  }
}
//
// echo('<form method="post" action="">');
//
// echo('<input type="text" name="something" value="Smith" />');
//
// echo('<input type="submit" name="submit" />');
//
// echo('</form>');

if(isset($_POST['submit'])) {
  echo('You entered: ', htmlspecialchars($_POST["something"]));
}



$sql_balance = "SELECT total_balance() as tot_balance";

echo("<p>Query: " . $sql . "</p>\n");

echo ("<p> Query: ". $sql_balance . "</p>\n");

$result = $conn->query($sql);

$result_balance = $conn->query($sql_balance);

$num = $result->rowCount();
$num_balance = $result_balance->rowCount();


echo("<p>num: $num  records retrieved:</p>\n");

echo("<p>num: $num_balance  records retrieved:</p>\n");

echo("\n");
echo("\n");
foreach($result as $row)
{
  echo("\n");
  echo("<table><tbody><tr><td>account_number</td><td>branch_name</td><td>balance</td></tr><tr><td>");
  echo($row["account_number"]);
  echo("</td><td>");
  echo($row["branch_name"]);
  echo("</td><td>");
  echo($row["balance"]);
  echo("</td></tr>");
}

foreach($result_balance as $row)
{
  echo("\n");
  echo("<table><tbody><tr><td>tot_balance</td><tr><td>");
  echo($row["tot_balance"]);
  echo("</td><td>");
}

echo("</tbody></table>\n");
$conn = null;
echo("<p>Connection closed.</p>\n");

echo("<p>Test completed successfully.</p>\n");
