<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.         
        https://www.w3schools.com/js/js_htmldom_eventlistener.asp  
           -->
  
<@include header.tpl %>

  <h1>Select Layout For Import</h1><br><br>

   <input type="hidden" id="infile" name="infile" value= <%= infile %> >
  <form action="/layout/import?id=id$value">

 <label for="myfile">Select a layout file for import.</label>
 <label for="myfile">The file must contain 96, 384, or 1536 rows of data.</label>
<input type="file" accept=".txt" id="myfile" name="myfile"> 
</form> 
  
<script>
  function readSingleFile(e) {
      var file = e.target.files[0];
      if (!file) {
	  return;
      }
      var reader = new FileReader();
      reader.onload = function(e) {
	  var contents = e.target.result;
	  var numrows = lineCount(contents);
	  var format = numrows -1
	  var fname = file.name;
	  
	  if( numrows === 97 || numrows === 385 || numrows === 1537){
	        let formData = new FormData();
                formData.append("contents", contents);
        //        var link='/upload?format=' + format + "&origfile=" + fname;
                  var link='/upload';
                fetch(link, {method: "POST", body: formData});    
                      
	    
	  window.open( '/layout/viewlayout', "_top");
	 // displayContents(contents);
    	  }else{
    	  var message1="Layout Import file must have 96, 384 or 1536 rows of data.\\n";
    	  var message2 = numrows.toString();
    	  var message3 = " rows were found. Please try again.";
    	  var message4 = message1.concat(message2, message3);
	  window.alert(message4);
             }
      };
      reader.readAsText(file);
  }
  
  
  
  function displayContents(contents) {
      var element = document.getElementById('file-content');
      element.innerHTML = contents;
  }

 
  function lineCount( text ) {
      var nLines = 0;
      var allLines = text.split('\\n');
      for( var i = 0, n = allLines.length;  i < n;  ++i ) {
           if( allLines[i].length > 0  ) {
               ++nLines;
           }
       }
       return nLines;
 }

  
  document.getElementById('myfile').addEventListener('change', readSingleFile, false);
</script>
  
  
<div id="file-content"></div>
  
<@include footer.tpl %>

