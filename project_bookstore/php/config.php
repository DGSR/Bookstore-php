<?php
// Config
$host = 'localhost';
$user = 'root';
$password = 'vertrigo';
$database = 'base_bookstore';//config for your use
$link = mysqli_connect($host, $user, $password, $database);
mysqli_query ($link,"SET NAMES 'utf8'");
?>
