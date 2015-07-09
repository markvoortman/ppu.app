<?php 
	require ("MyCode.php");
	require ("MyConnection.php");

	$obj = new MyConnection();
	$obj->setConn();
	
	$qObj = new MyCode();
	$qObj->setConn($obj->getConn());
	
	$event = $_GET["event"];
	$org = $_GET["org"];
	$organizer = $_GET["organizer"];
	$email =  $_GET["email"];
	$phone =  $_GET["phone"];	
	$extension =  $_GET["extension"];
	$desc =  $_GET["desc"];
	$date =  $_GET["date"];
	$time =  $_GET["time"];
	$building =  $_GET["building"];
	$room =  $_GET["room"];
	$address1 =  $_GET["address1"];
	$address2 =  $_GET["address2"];
	$city =  $_GET["city"];
	$zip =  $_GET["zip"];
	
	$q = "SET search_path TO pointevent;
		INSERT INTO events VALUES(DEFAULT, '$event', '$org', '$organizer', '$email', '$phone', '$extension','$desc','$date','$time','6/25/2015','9/22/2015','$building','$room',DEFAULT,'$address1','$address2','$city','$zip', 50, 25)";
	
	$qObj->setQuery($q);
	$qObj->executeQuery($q);
?>
		