<?php 
include_once '../php/config.php';
session_start();
session_cache_expire(5);
$title="Admin page";
$header="Bookstore";
$footer="2019 PHP Admin";
if(isset($_SESSION['user']))
if($_SESSION['user']=='admin'){
$dop="<table><tr class='tr1'><td>Id_order</td><td>Order_date</td><td>Status</td><td>ID_user</td></tr>";
  $query=$link->prepare(sprintf("select * from orders"));
  $query->execute();
  $result=$query->get_result();
  while ($row = $result->fetch_array(MYSQLI_NUM)){
      $dop.= "<tr>";
        foreach ($row as $r)
        {
            $dop.= "<td>".$r."</td>";
        }
       $dop.= "</tr>";
    }
    $dop.="</table>";
  $query->close();
      
if(isset($_REQUEST["del"]))
{
          $query=$link->prepare(sprintf("Call DelOrd(?)"));
      $query->bind_param("i",$_REQUEST["n"]);
      $query->execute();
      $query->close();
}
$article="<h2>Adin</h2>
        Table Orders".$dop."
        <form action='admin.php' method='get'>Order number to Delete
    <input type='text' name='n'/><br>
    <input type='submit' name='del' value='Delete'/>
    </form>";
include_once '../template/template.php';
}else{
  $article="";
  include_once '../template/template.php';    
}
mysqli_close($link);
?>