<?php 
// Main Page
// Mail sender and gd usage from draw.php
    include_once 'php/config.php'; 
    session_cache_expire(5);
    session_start();
    $title="Bookstore";
    $header="Bookstore<br><img src='pages/draw.php'>";
    $footer="2019 Done";
    $article="<h2>Welcome to a bookstore</h2><p>
                Enter using login and pass<br />
                To make an order press button .. <br />
                To see previous orders press button  .. <br/>
            </p>
            Send an e-mail
            <form action='index.php' method='get'>Address<input name='address'><br>
            Text: <input name='text'><br><input type='submit' name='send'></form>";
    if(isset($_REQUEST["send"]))
    {
        $headers =  'MIME-Version: 1.0' . "\r\n"; 
        $headers .= 'From: Your name <info@address.com>' . "\r\n";
        $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n"; 
        mail($_REQUEST["address"], "", $_REQUEST["text"],$headers); 
    }
    include_once 'template/template.php';
?>
