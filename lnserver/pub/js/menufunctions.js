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
        document.getElementById('edit_psform').submit(); return false;
    }
}

function groupPlateSet(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length < 2 ){
	window.alert("Please select two or more plate sets!");}
    else {
        window.location="/plateset/group";
    }
}

function reformatPlateSet(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length > 1 ){
	window.alert("Please select (only) one plate set!");}
    else {
        document.getElementById('edit_psform').submit(); return false;
    }
}

function importPlateSet(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length > 1 ){
	window.alert("Please select (only) one plate set to associate data with!");}
    else {
        document.getElementById('edit_psform').submit(); return false;
    }
}

function exportPlateSet(){
    if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length > 1 ){
	window.alert("Please select at least  one plate set for data export!");}
    else {
        window.location= "/plateset/group";
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



