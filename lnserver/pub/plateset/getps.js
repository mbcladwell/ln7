function getpsSelection(e) {
    
    switch( e.target.value) {
  case "group":
	document.getElementById("import").disabled = true;
	document.getElementById("export").disabled = true;
	if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length < 2 ) {window.alert("Please select two or more plate sets!");}
    break;
  case "reformat":
	document.getElementById("import").disabled = true;
	document.getElementById("export").disabled = true;
	if(getCheckedBoxes("plateset-id") == null || getCheckedBoxes("plateset-id").length > 1 ) {window.alert("Please select (only) one plate set!");}
    break;
  
  case "importradio":
	document.getElementById("import").disabled = false;
	document.getElementById("export").disabled = true;
    break;
  case "exportradio":
	document.getElementById("import").disabled = true;
	document.getElementById("export").disabled = false;

	break;
  
  default:
    // code block
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



// Call as
var checkedBoxes = getCheckedBoxes("plateset-id");

// clear all radio selections when a checkbox is clicked
function handleChkbxClick(){
    document.getElementById("group").checked = false;
    document.getElementById("reformat").checked = false;
    document.getElementById("importradio").checked = false;
    document.getElementById("exportradio").checked = false;
}
