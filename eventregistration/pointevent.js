$(document).ready(function() {
	$("#eventHelp").hide();
	$("#orgHelp").hide();
	$("#onCampusHelp").hide();
	$("#attendHelp").hide();
	$("#offCampusHelp").hide();
	$("#onBuilding").hide();
	$("#onRoom").hide();
	$("#offName").hide();
	$("#address1").hide();
	$("#address2").hide();
	$("#city").hide();
	$("#state").hide();
	$("#zip").hide();
	$("#limit").hide();
	
	$('#oncampus').click(function() {
		if($('#oncampus').is(':checked')) { 
			oncampus();
		}
	});
	$('#offcampus').click(function() {
		if($('#offcampus').is(':checked')) { 
			offcampus();
		}
	});
	
	$('#attendyes').click(function() {
		if($('#attendyes').is(':checked')) { 
			attendlimit();
		}
	});

	$('#attendno').click(function() {
		if($('#attendno').is(':checked')) { 
			$("#limit").hide();
			hidehelp(attendHelp);
			hidehelp(onCampusHelp);
			hidehelp(offCampusHelp);
		}
	});
	
	$("#building").change(function() {
		 onaddress(this.value);
		});
});

function showhelp(param) {
	if ($(param).is(':visible') == false) {
		$(param).removeClass('animated zoomOut'); 
		$(param).addClass('animated zoomIn');
		$(param).show();
	}
}

function hidehelp(param) {
	$(param).removeClass('animated zoomIn'); 
	$(param).addClass('animated zoomOut'); 
	setTimeout(function(){ $(param).hide(); }, 200);
}

function oncampus() {
	$("#offName").hide();
	$("#onBuilding").show();
	$("#onRoom").show();	
	$("#offName").hide();
	
	hidehelp(offCampusHelp);
	showhelp(onCampusHelp);
	hidehelp(attendHelp);
	
	oncampusfields("#address1");
	oncampusfields("#address2");
	oncampusfields("#city");
	oncampusfields("#state");
	oncampusfields("#zip");
}

function oncampusfields(param) {
	$(param).show();
	$(param + "input").empty();
	$(param + "input").prop("readonly", true);
	$(param + "input").css("background-color", "#E8E8E8");	
}

function offcampus() {
	$("#offName").show();
	$("#onBuilding").hide();
	$("#onRoom").hide();	
	
	showhelp(offCampusHelp);
	hidehelp(onCampusHelp);
	hidehelp(attendHelp);
	
	offcampusfields("#address1");
	offcampusfields("#address2");
	offcampusfields("#city");
	offcampusfields("#state");
	offcampusfields("#zip");
}

function offcampusfields(param) {
	$(param).show();
	$(param + "input").val("");
	$(param + "input").prop("readonly", false);
	$(param + "input").css("background-color", "white");	
}

function attendlimit() {
	$("#limit").show();
	showhelp(attendHelp);
	hidehelp(onCampusHelp);
	hidehelp(offCampusHelp);
}

function onaddress(param) {
	if (param == "westpenn") {
		$("#address1input").val("210 Wood Street");
		$("#cityinput").val("Pittsburgh"); 
		$("#stateinput").val("Pennsylvannia"); 
		$("#zipinput").val("15222"); 
	}
	else if (param == "academic") {
		$("#address1input").val("201 Wood Street");
		$("#cityinput").val("Pittsburgh"); 
		$("#stateinput").val("Pennsylvannia"); 
		$("#zipinput").val("15222"); 		
	}
	else if (param == "lawrence") {
		$("#address1input").val("201 Wood Street");
		$("#cityinput").val("Pittsburgh"); 
		$("#stateinput").val("Pennsylvannia"); 
		$("#zipinput").val("15222"); 	
	}	
}

function newevent() {
	var event = $("#event").val();
	var org = $("#org").val();
	var organizer = $("#organizer").val();
	var email = $("#email").val();
	var phone = $("#phone").val();
	var extension = $("#extension").val();
	var desc = $("#desc").val();
	var date = $("#date").val();
	var time = $("#time").val();
	var building = $("#building").val();
	var room = $("#room").val();
	var address1 = $("#address1input").val();
	var address2 = $("#address2input").val();
	var city = $("#cityinput").val();
	var zip = $("#zipinput").val();
	
	var target = "http://bus2.pointpark.edu/~fmali/pointevent/pointevent.php?event=" + event + "&org=" + org + "&organizer=" + organizer + "&email=" + email + "&phone=" + phone +
		"&extension=" + extension + "&desc=" + desc + "&date=" + date + "&time=" + time + "&building=" + building + "&room=" + room + "&address1=" + address1 + "&address2=" + address2 +
		"&city=" + city + "&zip=" + zip; 
	$.getJSON(target, function(results) {
		$.each(results, function(i, key) { 
		});
	});		
}