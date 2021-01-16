<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <div class="container">
  <h2>Add a Plate Set To Project PRJ-</h2>

  <form action="/plateset/addaction?name=pname$value&description=descr$value" method="get">
 <div class="form-group">   
    <label for="name">Plate Set Name:</label>  <input type="text"  class="form-control" id="psname" name="psname" value="">
 </div>
 <div class="form-group">   
   <label for="descr">Description:</label>  <input type="text"  class="form-control" id="descr" name="descr" value="">
 </div>
 <div class="form-row">
 <div class="form-group  col-md-6">   
   <label for="numplates">Number of Plates:</label>  <input type="text"  class="form-control"  id="numplates" name="numplates" value="">
 </div>
 <div class="form-group col-md-6">
   <label for="format">Plate Format:</label>
   <select name="format"  class="custom-select" id="format">
     <option value="96">96</option>
     <option value="384">384</option>
     <option value="1536">1536</option>
   </select>
 </div>
 </div>
 <div class="form-row">
   <div class="form-group col-md-6">
     <label for="type">Plate Type:</label>
     <select name="type"  class="custom-select" id="type" onchange="typeSelection(event)"> <%= plate-types %></select> 
   </div>
   <div class="form-group col-md-6">
     <label for="sample">Sample Layout:</label> 
     <select name="sample"  class="custom-select" id="sample"> <%= sample-layouts %> </select>
   </div>
 </div>
 
 <div class="form-row">
   <label for="target-layout">Target Layout:</label> &nbsp;&nbsp;&nbsp;   <label for="target-desc"><%= trg-desc %></label> 
   <select name="target-layout"  class="custom-select" id="target-layout"  onchange="targetSelection(event)"> <%= target-layouts %>  </select>
 </div>

 <div class="form-row">
    <div class="form-group col-md-6">
   <input type="submit"  class="btn btn-primary" value="Submit" id="importButton" name="importButton" enabled>
    </div>
    </div>
</form> 

   <button class="btn btn-primary" type="button" id="loadingButton" name="loadingButton" enabled>
  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" ></span>
  Loading...
</button>


  
</div>
  
<script>
    document.getElementById("importButton").style.display = "inline";
    document.getElementById("loadingButton").style.display = "none"; 
  
  function myFunction() {
      var x = document.getElementById("importButton");
      x.style.display = "none";
      var y = document.getElementById("loadingButton");
      y.style.display = "inline";
  }

  var temp = <%= format %>;
  var mySelect = document.getElementById('format');

  for(var i, j = 0; i = mySelect.options[j]; j++) {
      if(i.value == temp) {
          mySelect.selectedIndex = j;
          break;
      }
  }
    
</script>


<script src="addps.js"></script>


<@include footer.tpl %>

