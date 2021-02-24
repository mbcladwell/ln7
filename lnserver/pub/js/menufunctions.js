function editProject(){
    if(getCheckedBoxes("prjid") == null || getCheckedBoxes("prjid").length > 1 ){
	window.alert("Please select (only) one project set to edit!");}
    else {
        document.getElementById('edit_project_form').submit(); return false;
    }
}

function editPlateSet(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length > 1 ){
	window.alert("Please select (only) one plate set to edit!");}
    else {
    // from the html page getps:
    //<form action="/plateset/editps" method="post" id="edit_psform">
    // all methods will have to activate this unless they can go directly to the page of interest
    //most likely I will need to determine which checkboxes are selected and in this case, edit
    //determine the name and description of the plate set
    	var hidden = document.createElement("input");
	hidden.type = "hidden";
	hidden.name = "activity";
	hidden.value = "edit";
	var f = document.getElementById("edit_psform");
	f.appendChild(hidden);
	f.setAttribute("action", "/plateset/editps");
	f.setAttribute("method", "POST");	
	f.submit(); return false;
	
        //document.getElementById('edit_psform').submit(); return false;
    }
}

function groupPlateSet(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length < 2 ){
	window.alert("Please select two or more plate sets!");}
    else {
    	var hidden = document.createElement("input");
	hidden.type = "hidden";
	hidden.name = "activity";
	hidden.value = "group";
	var f = document.getElementById("edit_psform");
	f.appendChild(hidden);
	f.setAttribute("action", "/plateset/group");
	f.setAttribute("method", "POST");	
	f.submit(); return false;

    }
}

function reformatPlateSet(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length > 1 ){
	window.alert("Please select (only) one plate set!");}
    else {
 	var hidden = document.createElement("input");
	hidden.type = "hidden";
	hidden.name = "activity";
	hidden.value = "reformat";
	var f = document.getElementById("edit_psform");
	f.appendChild(hidden);
	f.attr("action", "/plateset/reformat");
	f.submit(); return false;
    }
}

function importPlateSetData(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length > 1 ){
	window.alert("Please select (only) one plate set to associate data with!");}
    else {
 	var hidden = document.createElement("input");
	hidden.type = "hidden";
	hidden.name = "activity";
	hidden.value = "import";
	var f = document.getElementById("edit_psform");
	f.appendChild(hidden);
	f.submit(); return false;
    }
}

function exportPlateSet(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length > 1 ){
	window.alert("Please select at least  one plate set for data export!");}
    else {
 	var hidden = document.createElement("input");
	hidden.type = "hidden";
	hidden.name = "activity";
	hidden.value = "export";
	var f = document.getElementById("edit_psform");
	f.appendChild(hidden);
	f.submit(); return false;
    }
}


 
function getCheckedBoxes(chkboxName) {
  var checkboxes = document.getElementsByName(chkboxName);
  var checkboxesChecked = [];
  // loop over them all
  for (var i=0; i<checkboxes.length; i++) {
     // And stick the checked ones onto an array...
     if (checkboxes[i].checked) {
        checkboxesChecked.push(checkboxes[i]);
     }
  }
  // Return the array if it is non-empty, or null
  return checkboxesChecked.length > 0 ? checkboxesChecked : null;
}



