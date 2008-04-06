<?php
	include('SimpleBackpack.php');
	$bp = new SimpleBackpack('sikelianos', 'aac9eee6defd8d18121a85a17fece3c6feb7aa69');
	$result = $bp->export_backpack();
	echo $result;
?>
