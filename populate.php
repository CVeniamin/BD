<?php
require_once './db.php';

$queries = file_get_contents("./populate.sql");

foreach (array_filter(array_map('trim',explode($queries,"\r\n"))) as $query){
    echo $query . PHP_EOL;
    try{
        $db->query($query);
    }catch (PDOException $exception){
        echo $exception->getMessage();
    }
}

