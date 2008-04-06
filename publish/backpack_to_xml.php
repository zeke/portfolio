<?php
	include('SimpleBackpack.php');
	$bp = new SimpleBackpack('username', 'token');
	$result = $bp->export_backpack();
	echo $result;
?>
