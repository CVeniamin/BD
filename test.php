<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>First php on delta</title>
  </head>
  <body>
  <? php
  	$host="db.ist.utl.pt";
  	$user="ist182028";
  	$password="aaqq2196";
  	$dbname = $user;

  	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password);
    $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  	echo("<p>Connected to MySQL database $dbname on $host as user $user</p>\n");

  	$sql = "SELECT * FROM account;";

  	echo("<p>Query: " . $sql . "</p>\n");

  	$result = $connection->query($sql);

  	$num = $result->rowCount();

  	echo("<p>$num records retrieved:</p>\n");

  	echo("\n");
  	echo("\n");
  	foreach($result as $row)
  	{
  		echo("\n");
    	echo("<table border="1"><tbody><tr><td>account_number</td><td>branch_name</td><td>balance</td></tr><tr><td>");
  		echo($row["account_number"]);
  		echo("</td><td>");
  		echo($row["branch_name"]);
  		echo("</td><td>");
  		echo($row["balance"]);
  		echo("</td></tr></tbody></table>\n");
      $connection = null;
    	echo("<p>Connection closed.</p>\n");
    	echo("<p>Test completed successfully.</p>\n");
    }
    ?>
    <p>
      hue!
    </p>
</body>
</html>
