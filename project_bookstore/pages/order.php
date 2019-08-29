<?php 
//Order Page
//Offers selection or search through parameters
include_once '../php/config.php';
session_start();
session_cache_expire(5);
$title="Order";
$header="Bookstore";
$footer="2019 PHP";
$strz="";
// Author chosen
if (isset($_SESSION['user'])) {
if(isset($_REQUEST["aut"])){
  $query=$link->prepare(sprintf("Call authorp(?)"));
  $query->bind_param("s", $_REQUEST["sela"]);
  $query->execute();
  $result=$query->get_result();
  $strz="Book from author ".$_REQUEST["sela"]."<br><form action='order2.php' method='get'><select name='selb' id='selz'><option selected disabled>Select a book</option></select></br>
        <input type='submit' name='genz' value='Select a book'/></form><script>";
  while ($row = $result->fetch_array(MYSQLI_NUM)){
    foreach ($row as $r){
       $strz.="document.getElementById('selz').appendChild(new Option(\"".$r."\"));";
    }
  }
  $strz.="</script>";
  $query->close();
}
// Publisher chosen
if(isset($_REQUEST["pub"])){
  $query=$link->prepare(sprintf("Call publishp(?)"));
  $query->bind_param("s", $_REQUEST["selp"]);
  $query->execute();
  $result=$query->get_result();
  $strz=Book from publisher ".$_REQUEST["selp"]."<br><form action='order2.php' method='get'><select name='selb' id='selz'><option selected disabled>Select a book</option></select></br>
        <input type='submit' name='genz' value='Select a book'/></form><script>";
  while ($row = $result->fetch_array(MYSQLI_NUM)){
    foreach ($row as $r){
       $strz.="document.getElementById('selz').appendChild(new Option(\"".$r."\"));";
    }
  }
  $strz.="</script>";
  $query->close();
}
//Genre chosen
if(isset($_REQUEST["jen"])){
  $query=$link->prepare(sprintf("Call genrep(?)"));
  $query->bind_param("s", $_REQUEST["selg"]);
  $query->execute();
  $result=$query->get_result();
  $strz="Book by genre ".$_REQUEST["selg"]."<br><form action='order2.php' method='get'><select name='selb' id='selz'><option selected disabled>Select a book</option></select></br>
        <input type='submit' name='genz' value='Select a book'/></form><script>";
  while ($row = $result->fetch_array(MYSQLI_NUM)){
    foreach ($row as $r){
       $strz.="document.getElementById('selz').appendChild(new Option(\"".$r."\"));";
    }
  }
  $strz.="</script>";
  $query->close();
}
//Renders Selects
$article="<h2>Book Order</h2><p>Select a book</p>
        From all books present<form action='order2.php' method='get'><select name='selb' id='selb'><option selected disabled>Select a book</option></select></br>
        <input type='submit' name='gen' value='Select a book'/></form>
        <table><tr>   
        <td>By author
            <form action='order.php' method='get'><select name='sela' id='sela'><option selected disabled>Select an author</option></select></br>
            <input type='submit' name='aut' value='Select an author'/></form></td>
        <td>By publisher
            <form action='order.php' method='get'><select name='selp' id='selp'><option selected disabled>Select a publisher</option></select></br>
            <input type='submit' name='pub' value='Select a publisher'/></form></td>
        <td>By genre
            <form action='order.php' method='get'><select name='selg' id='selg'><option selected disabled>Select a genre</option></select></br>
            <input type='submit' name='jen' value='Select a genre'/></form></td></tr></table>".$strz;
include_once '../template/template.php';  
echo ("<html><script>");
//Filling selects
$query=sprintf("Select Book_name from book");
    if ($result=mysqli_query($link,$query))
    {
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo("document.getElementById('selb').appendChild(new Option(\"".$row["Book_name"]."\"));");
            }
        } 
        mysqli_free_result($result);
    }
$query="Select Author_name From authors";
if ($result=mysqli_query($link,$query)){
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            echo("document.getElementById('sela').appendChild(new Option(\"".$row["Author_name"]."\"));");
        }
    } 
    mysqli_free_result($result);
}
$query=sprintf("Select Publisher_name From publishers");
if ($result=mysqli_query($link,$query))
{
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            echo("document.getElementById('selp').appendChild(new Option(\"".$row["Publisher_name"]."\"));");
        }
    } 
    mysqli_free_result($result);
}
$query=sprintf("Select Genre_name From genres");
if ($result=mysqli_query($link,$query))
{
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            echo("document.getElementById('selg').appendChild(new Option(\"".$row["Genre_name"]."\"));");
        }
    } 
    mysqli_free_result($result);
}
echo ("</script></html>");
mysqli_close($link);
}else{
  $article="";
  include_once '../template/template.php';    
}
?>
  