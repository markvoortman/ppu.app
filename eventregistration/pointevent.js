function loadres() {
		var target = "test.php"; 
		$.getJSON(target, function(results) {
			$.each(results, function(i, key) { 
				$("#eventtable > tbody").append("<tr><td>" + key.event + "</td><td>" + key.date + "</td><td>" + key.time + "</td><td>" + key.building +  "</td><td><button class='ui-btn'>View Event</button></td></tr>");
			});
		});					
};

function hideallhelp() {
	$("#eventHelp").hide();
	$("#orgHelp").hide();
	$("#advisorHelp").hide();
	$("#contactHelp").hide();
	$("#descHelp").hide();
	$("#onoffHelp").hide();
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
}

$(document).ready(function() {
	hideallhelp();
	
	$('#oncampus').click(function() {
		if($('#oncampus').is(':checked')) { 
			checkhelp('#onCampusHelp'); 
			oncampus();
			$("#location").val("");		
			$("#address1input").val("");
			$("#address2input").val("");
			$("#cityinput").val("");
			$("#stateinput").val("");
			$("#zipinput").val("");
			$("#locinput").val("");
		}
	});
	$('#offcampus').click(function() {
		if($('#offcampus').is(':checked')) { 
			checkhelp('#offCampusHelp');
			offcampus();
			$("#room").val("");
			$("#building").val(0); //Why doesn't this work?
			$("#building").selectmenu("refresh");
		}
	});
	
	$('#attendyes').click(function() {
		if($('#attendyes').is(':checked')) { 
			$("#limit").show();		
			checkhelp('#attendHelp');
			showhelp('#attendHelp');
		}
	});

	$('#attendno').click(function() {
		if($('#attendno').is(':checked')) { 
			$("#limit").hide();
			checkhelp('#attendHelp');
			hidehelp('#attendHelp');
		}
	});
	
	$("#building").change(function() {
		 onaddress(this.value);
	});

	$('.banner').unslider({
		speed: 500,               //  The speed to animate each slide (in milliseconds)
		delay: 3000,              //  The delay between slide animations (in milliseconds)
		complete: function() {},  //  A function that gets called after every slide animation
		keys: true,               //  Enable keyboard (left, right) arrow shortcuts
		dots: true,               //  Display dot navigation
		fluid: false              //  Support responsive design. May break non-responsive designs
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

function checkhelp(param) {
	if ($("#contactHelp").is(':visible')) {
		if (param != "#contactHelp") {
			hidehelp("#contactHelp");
		}
	}
	if ($("#descHelp").is(':visible')) {
		if (param != "#descHelp") {
			hidehelp("#descHelp");
		}
	}
	if ($("#onCampusHelp").is(':visible')) {
		if (param != "#onCampusHelp") {
			hidehelp("#onCampusHelp");
		}
	}	
	if ($("#offCampusHelp").is(':visible')) {
		if (param != "#offCampusHelp") {
			hidehelp("#offCampusHelp");
		}
	}	
	if ($("#attendHelp").is(':visible')) {
		if (param != "#attendHelp") {
			hidehelp("#attendHelp");
		}
	}	
}

function oncampus() {
	$("#offName").hide();
	$("#onBuilding").show();
	$("#onRoom").show();	
	$("#offName").hide();
	
	hidehelp(offCampusHelp);
	showhelp(onCampusHelp);

	oncampusfields("#address1");
	oncampusfields("#address2");
	oncampusfields("#city");
	oncampusfields("#state");
	oncampusfields("#zip");
}

function oncampusfields(param) {
	$(param).hide();
	//$(param + "input").empty();
	$(param + "input").prop("readonly", true);
	//$(param + "input").css("background-color", "#E8E8E8");
}

function offcampus() {
	$("#offName").show();
	$("#onBuilding").hide();
	$("#onRoom").hide();	

	showhelp(offCampusHelp);
	hidehelp(onCampusHelp);
	
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
	var building = $("#building").val(); //.text
	var room = $("#room").val();
	var address1 = $("#address1input").val();
	var address2 = $("#address2input").val();
	var city = $("#cityinput").val();
	var zip = $("#zipinput").val();
	var location = $("#location").val();
	var limit = $("location").val();
	
	var target = "pointevent.php?type=1" + "&event=" + event + "&org=" + org + "&organizer=" + organizer + "&email=" + email + "&phone=" + phone +
		"&extension=" + extension + "&desc=" + desc + "&date=" + date + "&time=" + time + "&building=" + building + "&room=" + room + "&address1=" + address1 + "&address2=" + address2 +
		"&city=" + city + "&zip=" + zip + "&limit" + limit; 
	$.getJSON(target, function(results) {
		$.each(results, function(i, key) { 
		});
	});		
}

function errorcheck() {
	
	var errorcheck = false;
	
	//error check input field
	if (!$("#event").val()) {
        $("#event").addClass("error");
        $("#eventHelp > #error").empty();
        $("#eventHelp > #error").append("The Event Name field cannot be empty.<br>")
        errorcheck = true;
	}
	else if ($("#event").val()) {
		$("#event").removeClass("error");
        $("#eventHelp > #error").empty();	
        errorcheck = false;
	}
	
	//error check organization field
	if (!$("#org").val()) {
        $("#org").addClass("error");
        $("#orgHelp > #error").empty();
        $("#orgHelp > #error").append("The Organization field cannot be empty.<br>")
        errorcheck = true;
	}
	else if ($("#event").val()) {
		$("#org").removeClass("error");
        $("#orgHelp > #error").empty();		
        errorcheck = false;
	}

	//error check advisor/organizer field
	if (!$("#organizer").val()) {
        $("#organizer").addClass("error");
        $("#advisorHelp > #error").empty();
        $("#advisorHelp > #error").append("The Advisor/Organizer field cannot be empty.<br>")
        errorcheck = true;
	}
	else if ($("#organizer").val()) {
		$("#organizer").removeClass("error");
        $("#advisorHelp > #error").empty();		   
        errorcheck = false;
	}
	
	//error checkemail field
	if (!$("#email").val()) {
        $("#email").addClass("error");
        $("#contactHelp > .errorEmail").empty();
        $("#contactHelp > .errorEmail").append("The Email field cannot be empty.<br>")
        errorcheck = true;
	}
	else if ($("#email").val()) {
		$("#email").removeClass("error");
        $("#contactHelp > .errorEmail").empty();
        errorcheck = false;
	}
	
	//error check phone and extension fields
	if (!$("#phone").val() && !$("#extension").val()) {
		if (!$("#extension").val()) {
	        $("#phone").addClass("error");
	        $("#contactHelp > .errorPhone").empty();
	        $("#contactHelp > .errorPhone").append("The Phone field cannot be empty. Enter an extension if necessary, but it is not required.<br>")	
	        errorcheck = true;
		}
	}
	if ($("#extension").val() && !$("#phone").val()) {
	    $("#phone").addClass("error");
	    $("#extension").addClass("error");
	    $("#contactHelp > .errorExtension").empty();
        $("#contactHelp > .errorPhone").empty();
	    $("#contactHelp > .errorExtension").append("The Phone field cannot be empty if an extension is provided.<br>")		
	    errorcheck = true;
	}
	else if ($("#phone").val()) {
		$("#phone").removeClass("error");
		$("#extension").removeClass("error");
        $("#contactHelp > .errorPhone").empty();
	    $("#contactHelp > .errorExtension").empty();       
	    errorcheck = false;
	}
	
	//error check desc, date, time fields
	if (!$("#desc").val()) {
        $("#desc").addClass("error");
        $("#descHelp > .errorDesc").empty();
        $("#descHelp > .errorDesc").append("The Event Description field cannot be empty.<br>")
        errorcheck = true;
	}
	else if ($("#desc").val()) {
		$("#desc").removeClass("error");
        $("#descHelp > .errorDesc").empty();		
        errorcheck = false;
	}
	
	if (!$("#date").val()) {
        $("#date").addClass("error");
        $("#descHelp > .errorDate").empty();
        $("#descHelp > .errorDate").append("The Event Date field cannot be empty.<br>")
        errorcheck = true;
	}
	else if ($("#date").val()) {
		$("#date").removeClass("error");
        $("#descHelp > .errorDate").empty();
        errorcheck = false;
	}
	
	if (!$("#time").val()) {
        $("#time").addClass("error");
        $("#descHelp > .errorTime").empty();
        $("#descHelp > .errorTime").append("The Event Time field cannot be empty.<br>")
        errorcheck = true;
	}
	else if ($("#time").val()) {
		$("#time").removeClass("error");
        $("#descHelp > .errorTime").empty();
        errorcheck = false;
	}		
	
	//error check if on or off pressed
	if (!$("#oncampus").is(':checked') && !$("#offcampus").is(':checked')) {
        $("#onoffcampus > .ui-controlgroup-controls").addClass("error");
        $("#onoffHelp > #error").empty();
        $("#onoffHelp > #error").append("Please select On or Off campus.<br>")
        showhelp("#onoffHelp");
        errorcheck = true;
	}
	if ($("#oncampus").is(':checked') || $("#offcampus").is(':checked')) {
        $("#onoffcampus > .ui-controlgroup-controls").removeClass("error");
        $("#onoffHelp > #error").empty();	
        hidehelp("#onoffHelp");
        errorcheck = false;
	}
	
	//error check if on is pressed, but building and room are empty
	if ($("#oncampus").is(':checked') && $("#building").val() == 'empty') {
        $("#building-button").addClass("error");
        $("#onCampusHelp > .errorBuilding").empty();
        $("#onCampusHelp > .errorBuilding").append("Please select a Building on campus.<br>");
        errorcheck = true;
	}	
	
	else if ($("#oncampus").is(':checked') && $("#building").val() != 'empty') { 
        $("#building-button").removeClass("error");
        $("#onCampusHelp > .errorBuilding").empty();
        errorcheck = false;
	}	
	
	if ($("#oncampus").is(':checked') && !$("#room").val()) {
	   $("#room").addClass("error");
	   $("#onCampusHelp > .errorRoom").empty();
	   $("#onCampusHelp > .errorRoom").append("Please select a Room on campus.<br>");
	   errorcheck = true;
	}
	
	else if ($("#oncampus").is(':checked') && $("#room").val()) {
        $("#room").removeClass("error");
        $("#onCampusHelp > .errorRoom").empty();
        errorcheck = false;
	}
	
	//error check if attendence or or off pressed
	if (!$('#attendyes').is(':checked') && !$('#attendno').is(':checked')) { 
		$("#attendSet > .ui-controlgroup-controls").addClass("error");	
		$("#attendHelp > #error").empty();
		$("#attendHelp > #error").append("Please select yes or no for Attendence Limit");
		showhelp("#attendHelp");
		errorcheck = true;
	}

	else if ($('#attendyes').is(':checked') || $('#attendno').is(':checked')) { 
		$("#attendSet > .ui-controlgroup-controls").removeClass("error");	
		$("#attendHelp > #error").empty();
		errorcheck = false;
	}
	
	if (errorcheck == false) {
		if ($("#oncampus").is(':checked') && $('#attendyes').is(':checked')) {
			alert("on campus and attendenec limit yes");
			newevent();
		}
		if ($("#oncampus").is(':checked') && $('#attendno').is(':checked')) {
			alert("on campus and attendenec limit no");
			newevent();
		}
		if ($("#offcampus").is(':checked') && $('#attendyes').is(':checked')) {
			alert("off campus and attendenec limit yes");
			newevent();
		}
		if ($("#offcampus").is(':checked') && $('#attendno').is(':checked')) {
			alert("off campus and attendenec limit no");
			newevent();		
		}		
	}
}