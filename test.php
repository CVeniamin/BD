<html>
  <head>
    <title>First php on delta</title>
  </head>
  <body>
  <?php
  	$host="db.ist.utl.pt";
  	$user="ist182028";
  	$password="aaqq2196";
  	$dbname = $user;

  	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE =&gt; PDO::ERRMODE_WARNING));

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
  	}
  	echo("<table border="\&quot;1\&quot;"><tbody><tr><td>account_number</td><td>branch_name</td><td>balance</td></tr><tr><td>");
  		echo($row["account_number"]);
  		echo("</td><td>");
  		echo($row["branch_name"]);
  		echo("</td><td>");
  		echo($row["balance"]);
  		echo("</td></tr></tbody></table>\n");

          $connection = null;

  	echo("<p>Connection closed.</p>\n");

  	echo("<p>Test completed successfully.</p>\n");

    ?>
    <p>
      hue!
    </p>
</body>
</html>
