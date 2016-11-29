<html>
    <body>
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
        <p>Account Number: <input type="text" name="account_number" value="<?php echo htmlspecialchars($_REQUEST['account_number']);?>"/>
        </p>
        <p>New balance: <input type="text" name="balance"/></p>
        <p><input type="submit" value="Submit"/></p>
    </form>

<?php
    require_once './dbconfig.php';

    function test_input($data) {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
    function render_view($result){
        echo("<table border=\"1\">\n");
        echo("<tr><td>account_number</td><td>branch_name</td><td>balance</td></tr>\n");

        foreach($result as $row)
        {
            echo("<tr><td>");
            echo($row['account_number']);
            echo("</td><td>");
            echo($row['branch_name']);
            echo("</td><td>");
            echo($row['balance']);
            echo("<td><a href=\"index.php?account_number={$row['account_number']}\">Change balance</a></td>\n");
            echo("</tr>\n");
        }
        echo("</table>\n");
    }
    try
    {
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "SELECT account_number, branch_name, balance FROM account;";
    
        $result = $db->query($sql);
        
        render_view($result);

        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            $account_number = test_input($_POST["account_number"]);
            $balance = test_input($_POST["balance"]);

            $db->query("start transaction;");

            $sql = "UPDATE account SET balance = $balance WHERE account_number = '$account_number';";

            echo("<p>$sql</p>");

            $db->query($sql);

            $db->query("commit;");

            $page = $_SERVER['PHP_SELF'];
            $sec = "5";
            header("Refresh: $sec; url=$page");

        }


        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
