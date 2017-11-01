<?php 
	require ("MyCode.php");
	require ("MyConnection.php");

	$obj = new MyConnection();
	$obj->setConn();
	
	$qObj = new MyCode();
	$qObj->setConn($obj->getConn());
	
	
	$q = "SET search_path TO pointevent;
		SELECT event, date, time, building, offlocation, address1, address2, city, zip, description
		FROM events";
	
	$qObj->setQuery($q);
	$data = $qObj->jsonTable();
	echo($data);
?>
		