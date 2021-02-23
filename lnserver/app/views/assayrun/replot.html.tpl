<!-- assayrun#getforpsid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">
  
  <h2>Assay Run AR-<%= arid %></h2>
  <table id="artable" class="display table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr></thead>
    <tbody><%= body %></tbody>
  </table>
<div class="row">
<img src=<%= outfile2 %> align="left">
</div>
<form action="replot" method="POST" >

  <div class="row">
    <div class="col">
      <div class="form-group">
	<label for="response">Response:</label><select name="response"  class="form-control" id="response">
	  <option value="0">Background Subtracted</option>
	  <option value="1">Normalized</option>
	  <option value="2">Normalized to Positive Controls</option>
	  <option value="3">% enhanced</option>
	</select>
      </div>
    </div>
    <div class="col">
      <div class="form-group">
	<label for="threshold">Threshold - algorithmic:</label><select name="threshold"  class="form-control" id="threshold">
	  <option value="1">mean(pos)</option>
	  <option value="2">mean(neg) + 2SD</option>
	  <option value="3">mean(neg) + 3SD</option>
	</select>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col">
  <input type="submit"  class="btn btn-primary" value="Replot">
    </div>
    <div class="col">
      <div class="form-group">
	<label for="manthreshold">OR manually enter:</label><input type="text" id="manthreshold" name="manthreshold">
      </div>
    </div>      
  </div>

  <input type="hidden" id="infile" name="infile" value=<%= infileq %>>
  <input type="hidden" id="infile2" name="infile2" value=<%= infile2q %>>
  <input type="hidden" id="arid" name="arid" value=<%= aridq %>>
  <input type="hidden" id="bodyencode" name="bodyencode" value=<%= body-encodeq %>>
 <input type="hidden" id="hitlistsencode" name="hitlistsencode" value=<%= hit-lists-encodeq %>>

   
</form>
<hr>
<h2>Hit Lists for AR-<%= arid %></h2>
<table id="hltable" class="display table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>AR Name</th><th>Assay Type</th><th>Hit List</th><th>HL Name</th><th>Description</th><th>Number of Hits</th></tr></thead>
<tbody><%= hit-lists %></tbody>
</table>


</div>

<script>          
$(document).ready(function() {
    $('#artable').DataTable();
} );
  
  
$(document).ready(function() {
    $('#hltable').DataTable();
} );

</script>

<@include footer.tpl %>
