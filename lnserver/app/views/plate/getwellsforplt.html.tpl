<!-- plate#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">
    <h2>Wells for PLT-<%= pltid %></h2>
<table class="display table table-striped table-bordered"><thead><tr><th>Plate Set</th><th>Plate</th><th>Well</th><th>Order</th><th>Sample</th><th>Accession</th></tr></thead>
    <tbody> <%= body %></tbody>
</table>
<form action="/plate/getwellsforps" method="post">
    
    <div class="row">
	<div class="col">
	    <button type="submit" class="btn btn-primary">All Wells for PS-<%=  psid  %></button>
	</div> 
	<div class="col">
            <input type="checkbox" class="custom-control-input" id="includecontrols" name="includecontrols">
            <label class="custom-control-label" for="includecontrols">Include controls</label>
	</div>
	<div class="col">
	</div>
    </div>
    <input type="hidden" id="psid" name="psid" value=<%= psidq %>>
</form>
 
  </div>
 



<script>          
$(document).ready(function() {
     $('table.display').DataTable(
	 {
             dom: 'lBfrtip',
             buttons: [
		 'copyHtml5',
		 'excelHtml5',
		 'csvHtml5',
		 'pdfHtml5'
             ]
	 }
     );
 } );

</script>


<@include footer.tpl %>
