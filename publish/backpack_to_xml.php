<?php
	include('SimpleBackpack.php');
	$bp = new SimpleBackpack('sikelianos', 'ereiamJH');
	$result = $bp->export_backpack();
	echo $result;
?>
