<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
<?php

  // $host="db.ist.utl.pt";
	// $user="ist182028";
  $host= "localhost";
  $user = "root";
	$password="";
	$dbname = "bd";

  try {
    $connection = new PDO("mysql:host=$host;dbname=$dbname", $user, $password,array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
  } catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
    exit;
  }

	echo("<p>Connected to MySQL database $dbname on $host as user $user </p>");

	$sql = "SELECT * FROM account";

	echo("<p>Query: " . $sql . "</p>\n");

	$result = $connection->query($sql);

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
?>
</body>
</html>
