<!-- assayrun#getforpsid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">
  
  <h2>Assay Run AR-<%= id %></h2>
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
    </div>
    <div class="col">
      <div class="form-group">
	<label for="manthreshold">OR manually enter:</label><input type="text" id="manthreshold" name="manthreshold">
      </div>
    </div>      
  </div>

  <input type="hidden" id="infile" name="infile" value=&quot;<%= infile %>&quot; >
  <input type="hidden" id="infile2" name="infile2" value=&quot;<%= infile2 %>&quot; >
  <input type="hidden" id="id" name="id" value=&quot;<%= id %>&quot; >
  <input type="hidden" id="body" name="body" value=&quot;<%= body-encode %>&quot; >

  <input type="submit"  class="btn btn-primary" value="Replot">
   
</form>


</div>

<script>          
$(document).ready(function() {
    $('#artable').DataTable();
} );
  

</script>

<@include footer.tpl %>
