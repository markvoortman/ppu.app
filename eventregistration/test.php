<?php 
	require ("MyCode.php");
	require ("MyConnection.php");

	$obj = new MyConnection();
	$obj->setConn();
	
	$qObj = new MyCode();
	$qObj->setConn($obj->getConn());
	
	
	$q = "SET search_path TO pointevent;
		SELECT event, date, time, building, offlocation
		FROM events";
	
	$qObj->setQuery($q);
	$data = $qObj->jsonTable();
	echo($data);
?>
		