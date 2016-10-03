<?php
  require_once 'dbconfig.php';

try {
  $conn= new PDO("mysql:host=$host;dbname=$dbname", $username,$password);
} catch (PDOException $pe) {
  die("Couldn't Connected to the database $dbname:".$pe->getMessage());
}
echo("<p>Connected to MySQL database $dbname on $host</p>");

$sql = "SELECT * FROM account";

echo("<p>Query: " . $sql . "</p>\n");

$result = $conn->query($sql);

$num = $result->rowCount();

echo("<p>$num records retrieved:</p>\n");

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
echo("</tbody></table>\n");
$connection = null;
echo("<p>Connection closed.</p>\n");

echo("<p>Test completed successfully.</p>\n");
