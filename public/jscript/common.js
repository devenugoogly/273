function show_menu() {
	if (document.getElementById('gh-eb-My-o').style.display == "none")
		document.getElementById('gh-eb-My-o').style.display = "block";
	else
		document.getElementById('gh-eb-My-o').style.display = "none";
}

function show_bid() {
	document.getElementById('all').disabled=false;
	document.getElementById('bid').disabled=true;
	document.getElementById('bin').disabled=false;
	
	var x =document.getElementsByName('DirectBuy');
	var y=document.getElementsByName('Bid');
	
	console.log(y.length);
	for(var i=0; i<y.length; i++)
	y[i].style.display = "block";
	
	console.log(x.length);
	for(var j=0; j<x.length; j++)
	x[j].style.display = "none";
	
}

function show_direct_buy() {
	document.getElementById('all').disabled=false;
	document.getElementById('bid').disabled=false;
	document.getElementById('bin').disabled=true;
	
	var x =document.getElementsByName('DirectBuy');
	var y=document.getElementsByName('Bid');
	
	for(var i=0; i<y.length; i++)
	y[i].style.display = "none";
	
	for(var j=0; j<x.length; j++)
	x[j].style.display = "block";
}

function show_all() {
	document.getElementById('all').disabled=true;
	document.getElementById('bid').disabled=false;
	document.getElementById('bin').disabled=false;
	
	var x =document.getElementsByName('DirectBuy');
	var y=document.getElementsByName('Bid');
	
	for(var i=0; i<y.length; i++)
	y[i].style.display = "block";
	
	for(var j=0; j<x.length; j++)
	x[j].style.display = "block";
}


function show_editable() {
	document.getElementById('txtemail').disabled=false;
	document.getElementById('txtpwd').disabled=false;
	document.getElementById('txtpwd2').disabled=false;
	document.getElementById('txtfname').disabled=true;
	document.getElementById('txtlname').disabled=true;
	document.getElementById('txtmaddress').disabled=false;
	document.getElementById('txtcity').disabled=false;
	document.getElementById('txtstate').disabled=false;
	document.getElementById('txtzip').disabled=false;
	
	document.getElementById('update').style.display="block";
	document.getElementById('edit').style.display="none";
	
	
}