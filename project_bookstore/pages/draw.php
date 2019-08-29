<?php
// GD graphical library usage
// Draws 2 lines in a box
$myImage = imagecreate(50, 50); //empty box
$myGreen = imagecolorallocate($myImage, 255, 160, 0); //background
$myWhite = imagecolorallocate($myImage, 255, 255, 255);
imageline($myImage, 0, 0, 50, 50, $myWhite); //straight white line
imageline($myImage, 0, 50, 50, 0, $myWhite);
header("Content-type: image/png");
imagepng($myImage);
imagedestroy($myImage);
?>