<?php 
// Previous orders
include_once '../php/config.php'; 
session_cache_expire(5);
session_start();
$title="Previous orders";
$header="Bookstore";
$footer="2019 PHP";
if (isset($_SESSION['user'])) {
    if(isset($_REQUEST["ord"])){
        //Inserts data from order pages
      $query=$link->prepare(sprintf("Call InsOrd(?)"));
      $query->bind_param("s", $_SESSION["user"]);
      $query->execute();
      $query->close();
      
      $query=$link->prepare(sprintf("Call InsShop(?,?)"));
      $query->bind_param("is",$_REQUEST["quan"],$_COOKIE["book"]);
      $query->execute();
      $query->close();
    }
    //Render all orders
  $receipts="<table><tr class='tr1'><td>Order Number</td><td>Book name</td><td>Order Date</td><td>Author</td><td>Publication year</td><td>Publisher</td><td>Genre</td></tr>";
  $query=$link->prepare(sprintf("Call user_order(?)"));
  $query->bind_param("s", $_SESSION["user"]);
  $query->execute();
  $result=$query->get_result();
  while ($row = $result->fetch_array(MYSQLI_NUM)){
      $receipts.= "<tr>";
        foreach ($row as $r)
        {
            $receipts.= "<td>".$r."</td>";
        }
       $receipts.= "</tr>";
    }
    $receipts.="</table>";
  $query->close();
  
$article="<h2>Previous orders</h2>".$receipts."
        <p>
        </p>";
include_once '../template/template.php';
}else{
  $article="";
  include_once '../template/template.php';    
}    
?>