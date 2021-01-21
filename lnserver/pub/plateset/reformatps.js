

function sampRepSelection(e) {
    
    switch( e.target.value) {
  case "1":
  clearTargetRepSelect();
   $('#desttargrep').append('<option value="4">4</option>');
   break;
  case "2":
  clearTargetRepSelect();
    $('#desttargrep').append('<option value="2">2</option>');
   $('#desttargrep').append('<option value="4">4</option>');
 	break;
  case "4":
  clearTargetRepSelect();
 $('#desttargrep').append('<option value="1">1</option>');
  $('#desttargrep').append('<option value="2">2</option>');	
	break;	
  default:
    // code block
} 
}


function clearTargetRepSelect(){
var x = document.getElementById("desttargrep");
var i;
var len = document.getElementById("desttargrep").length;

for (i = 0; i < len; i++) {
  console.log(i, "  ", x[i]);
  
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



