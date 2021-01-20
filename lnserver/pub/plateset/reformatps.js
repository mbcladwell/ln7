

function sampRepSelection(e) {
    
    switch( e.target.value) {
  case "1":
  clearTargetRepSelect()
    document.getElementById('targrep').disabled = true;
   break;
  case "2":
    document.getElementById('targrep').disabled = false;
  clearTargetRepSelect()
    $('#targrep').remove(2,3);
    $('#targrep').append('<option value="1">1</option>');
 	break;
  case "4":
      document.getElementById('targrep').disabled = false;
  clearTargetRepSelect()
 $('#targrep').append('<option value="1">1</option>');
  $('#targrep').append('<option value="2">2</option>');
   $('#targrep').append('<option value="4">4</option>');
 	
	break;
  	
  default:
    // code block
} 
}


function clearTargetRepSelect(){
var x = document.getElementById("targrep");
var i;
for (i = 0; i < x.length; i++) {
  x.remove(i);
}
}



function targetSelection(e) {
switch(document.getElementById("format").value ) {
  case "96":
	document.getElementById("target-desc").text = "(only singlicates)";
   break;
 case "384":
	document.getElementById("target-desc").text = "(optional)";
   break;
 case "1536":
	document.getElementById("target-desc").text = "(optional)";
   break;


}



}



