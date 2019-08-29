<?php
//Confirmation page and quantity
include_once '../php/config.php';
session_cache_expire(5);
session_start();
$title="Confirm";
$header="Bookstore";
$footer="2019 PHP";
if (isset($_SESSION['user'])) {
$article="<h2>Confirmation</h2><p>Selected book</p>".$_REQUEST["selb"]."<br>
    <form action='receipt.php' method='get'>Type quantity here
    <input type='text' name='quan'/><br>
    <input type='submit' name='ord' value='Make an order'/>
    </form>";
include_once '../template/template.php';
setcookie("book",$_REQUEST["selb"]);
mysqli_close($link);
}else{
  $article="";
  include_once '../template/template.php';    
}    
?>