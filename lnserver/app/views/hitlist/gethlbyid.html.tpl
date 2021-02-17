<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">

    <div>
	<h2>Hits for HL-<%= hlid %></h2>
	<label>Number of hits: <%=  numhits  %></label>
  	<table id="hltable" class="table table-striped table-bordered">
	    <thead><tr><th>Name</th><th>Project</th><th>Accession</th></tr></thead>
	    <tbody> <%= body %></tbody>
	</table>
    </div>
    <hr>
    <form action="/hitlist/rearray" method="post">
	<div>
	<h2>Hit availability</h2>
	<label>Hit List HL-<%= hlid %> has <%=  numhits  %>  hits total</label>
  	<table id="hlavail" class="table table-striped table-bordered">
	    <thead><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>ID</th><th>Plate Set</th><th>Type</th><th>Format</th><th>Count</th></tr></thead>
	    <tbody> <%= body2 %></tbody>
	</table>
	</div>
        <input type="submit"  class="btn btn-primary" value="Rearray">

	<input type="hidden" id="prjid" name="prjid" value=<%= prjidq %>>
	<input type="hidden" id="sid" name="sid" value=<%= sidq %>>
	<input type="hidden" id="userid" name="userid" value=<%= useridq %>>
	<input type="hidden" id="group" name="group" value=<%= groupq %>>
	<input type="hidden" id="hlid" name="hlid" value=<%= hlidq %>>
	<input type="hidden" id="numhits" name="numhits" value=<%= numhitsq %>>

    </form>
    
</div>




<script>          
 $(document).ready(function() {
     $('#hltable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     });
 });


 $(document).ready(function() {
     $('#hlavail').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     });
 });

</script>



<@include footer.tpl %>
