<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <?php if(file_exists('css/styleweb.css')){ echo('<link href="css/styleweb.css" rel="stylesheet" type="text/css"/>');
     }else echo('<link href="../css/styleweb.css" rel="stylesheet" type="text/css"/>'); ?>
    <title><?php echo $title;?></title>
</head>
<body>
    <header>
        <h1><?php echo $header;?></h1>
    </header>
    <nav>
        <?php if(file_exists('php/login.php'))
         include_once 'php/login.php';
        else include_once '../php/login.php';?>
    </nav>
     <main>
        <aside>
            <ul>
                <?php if(file_exists('pages/order.php')){ echo("<li><a href='pages/order.php'>Order</a></li>
                <li class='navi'><a href='pages/receipt.php'>Previous Orders</a></li>
                ");
                 }else echo("<li><a href='../index.php'>Main page</a></li>
                <li class='navi'><a href='receipt.php'>Previous Orders</a></li>
                <li class='navi'><a href='order.php'>Order</a></li>");?>
            </ul>
        </aside>
        <article>
            <?php echo $article;?>
        </article>
    </main>
    <footer>
        <p><?php echo $footer;?></p>
    </footer>
</body>
</html>
