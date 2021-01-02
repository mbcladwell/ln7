<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
          
          
           -->
  
<@include header.tpl %>
<div class="container">
  <h1>Preview/Import Layout</h1>
  
  <p><h3>Sample Layout</h3></p>
 
  <image src= <%= spl-out2 %>>

<%= a %>

    
    <form action="updatedb">
      <div class="form-row">
	<div class="form-group col-md-6">
	  <label for="lytname">Layout Name</label>
	  <input type="text" class="form-control" id="lytname" placeholder="Name">
	</div>
	<div class="form-group col-md-6">
	  <label for="descr">Description</label>
	  <input type="text" class="form-control" id="descr" placeholder="Description">
	</div>
      </div>

      <div class="form-row">
	<div class="form-group col-md-6">
	  <label for="contloc">Control Location</label>
	  <input type="text" class="form-control" id="contloc" value="1S1T">
	</div>
      </div>
      <div class="form-row">
	<div class="form-group col-md-12">
	  <label for="numunk">Number unknowns:<%= nunks %></label>
	  <label for="numcon">Number controls:<%= ncontrols %></label>
	  <label for="format">Format: <%= format %></label>



	</div>
	</div>
      


      
 <label for="myfile">Continue with import of layout?:</label>
  <input type="submit" value="Import" >  
</form> 

    
  </div>
<@include footer.tpl %>

