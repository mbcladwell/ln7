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
	//  document.getElementById("format2").value = format.toString();
	  
	  if( numrows === 97 || numrows === 385 || numrows === 1537){
	        let formData = new FormData();
                formData.append("contents", contents);
                document.getElementById("myText").innerHTML = contents;
        //        var link='/upload?format=' + format + "&origfile=" + fname;
        
                //  var link='/layout/viewlayout';
               //fetch(link, {method: "PUT", body: formData});
       	  
              //var d = new Date();
	      //d.setTime(d.getTime() + (60*60*1000));
	     // var expires = "; expires="+ d.toUTCString();
	    //  document.cookie = 'infile=' +  document.getElementById('infile');
	    //  document.cookie = 'spl-out=' +  document.getElementById('spl-out');
	      
	      //document.cookie = 'format=' +  format + expires + "; path=/";
	      //document.cookie = 'selected-file=' +  file.name + expires + "; path=/";
	 
	 
	 // window.open( '/layout/viewlayout', "_top");
	// displayContents(contents);
    	  }else{
    	  var message1="Layout Import file must have 96, 384 or 1536 rows of data.\n";
    	  var message2 = format.toString();
    	  var message3 = " row(s) were found. Please try again.";
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
      var allLines = text.split('\n');
      for( var i = 0, n = allLines.length;  i < n;  ++i ) {
           if( allLines[i].length > 0  ) {
               ++nLines;
           }
       }
       return nLines;
 }

  
  document.getElementById('myfile').addEventListener('change', readSingleFile, false);
