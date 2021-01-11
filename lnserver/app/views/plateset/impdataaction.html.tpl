<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
         <@include header.tpl %>
  
  <div class="container">
  <h1>Import Data for PS-<%= psid %></h1>
  
    <br><br>
    <form action="impassdatadb" method="POST">
      <div class="form-row">
	<div class="form-group col-md-12">
	 <label for="ps-description">Plate set description:&nbsp;<%= ps-descr %></label>
	</div>
    </div>
 <div class="form-row">
<div class="form-group col-md-6">
 <label for="format">Format:&nbsp <%= format %></label>
</div>
	<div class="form-group col-md-6">
	  <label for="numplates">Number of plates:&nbsp<%= num-plates %></label>&nbsp&nbsp&nbsp
	
</div>
 </div>    
 <div class="form-row">
   <div class="form-group col-md-6">
     <label for="lytname">Assay Run Name</label>
     <input type="text" class="form-control" id="assayname" name="assayname" placeholder="Enter assay name">
   </div>
   <div class="form-group col-md-6">
     <label for="descr">Assay Run Description</label>
     <input type="text" class="form-control" id="assay-descr" name="assay-descr" placeholder="Enter assay description">
   </div>
 </div>
 <div class="form-row">	
   <div class="form-group col-md-6">
     <label for="assay-type">Assay type:</label>
     <select class="custom-select" id="assay-type">
       <option selected>Choose...</option>
       <option value="Elisa">Elisa</option>
       <option value="Octet">Octet</option>
       <option value="SNP">SNP</option>
       <option value="hc">HCS</option>
       <option value="HTRF">HTRF</option>
       <option value="FACS">FACS</option>
     </select>
   </div>
   <div class="form-group col-md-6">
     <label for="algorithm">Auto Hit Selection Algorithm:</label>
     <select class="custom-select" id="algorithm">
       <option selected>None</option>
       <option value="Elisa">Top N</option>
       <option value="Octet">mean(background) + 2SD</option>
       <option value="SNP">mean(background) + 3SD</option>
       <option value="hc">>0% enhanced</option>
      
     </select>
   </div>
  <!-- ComboItem[] algorithmTypes = new ComboItem[]{ new ComboItem(4,">0% enhanced"), new ComboItem(3,"mean(background) + 3SD"), new ComboItem(2,"mean(background) + 2SD"), new ComboItem(1,"Top N")}; -->
 </div>
 
 <div class="form-row">
   <div class="form-group col-md-12">
     <label for="layout">Plate Layout:&nbsp<%= lyt-txt %></label>&nbsp&nbsp&nbsp
     <label for="contolsloc">Control location:&nbsp<%= control-loc %></label>&nbsp&nbsp&nbsp   
   </div>
 </div>

 <div class="form-row">
   <div class="form-group col-md-12">
     <label for="layout">Data file name:&nbsp<%= filename %></label>&nbsp&nbsp&nbsp
   </div>
 </div>

 
 <input type="hidden" id="format" name="format" value=<%= format %>>
 <input type="hidden" id="lytsysname" name="lytsysname" value=<%= lyt-sys-name %>>
 <input type="hidden" id="controlloc" name="controlloc" value=<%= control-loc %>>
 <input type="hidden" id="nplates" name="numplates" value=<%= num-plates %>>
<input type="hidden" id="filebane" name="filename" value=<%= filename %>>

      
 <input  class="btn btn-primary" id="importButton" name="importButton" type="submit" value="Import Data" onclick="myFunction()" >

</form> 

 <button class="btn btn-primary" type="button" id="loadingButton" name="loadingButton" enabled>
  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" ></span>
  Loading...
</button>


    
</div>

<@include footer.tpl %>
<script>
  document.getElementById("importButton").style.display = "inline";
  document.getElementById("loadingButton").style.display = "none";
  
  function myFunction() {
      var x = document.getElementById("importButton");
      x.style.display = "none";
      var y = document.getElementById("loadingButton");
      y.style.display = "inline";
} 
    </script>


