<?php
//Authorization
//takes login and pass stored in db and checks input
//session destroy and admin page
$b=0;
$login=[];$password=[];
$query=sprintf("Select login From registry");
if ($result=mysqli_query($link,$query)){
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $login[$b]=$row["login"];
            $b++;
        }
    } 
    mysqli_free_result($result);
}
$b=0;
$query=sprintf("Select password From registry");
if ($result=mysqli_query($link,$query)){
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()){
            $password[$b]=$row["password"];
            $b++;
        }
    } 
    mysqli_free_result($result);
}

if(isset($_REQUEST['close'])){
    session_destroy();
}
if (isset($_REQUEST['check'])){
    for($b=0;$b<count($login);$b++){
        if ($_REQUEST['login'] == $login[$b] & $_REQUEST['password'] == $password[$b]){ 
            $_SESSION['user']=$login[$b];
            goto next;
        } 
    }    
    echo("ошибка"); 
}
next:
if (!isset($_SESSION['user'])) { ?>
<form class="log" action="" method="post"> 
    Login:<input maxlength="25" size="15" name="login">
    Password:<input type="password" maxlength="25" size="15" name="password">
<button name="check">Check</button>
</form> 
<?php 
}
else{ echo "Entered as ".$_SESSION['user'];
echo("<form><input type='submit' name='close' value='Выйти' /></form>");
if($_SESSION['user']='admin'){
    if(file_exists('pages/admin.php'))
    echo("<a href='pages/admin.php'>Admin</a>");
    else  echo("<a href='admin.php'>Admin</a>");
}
}
?>
