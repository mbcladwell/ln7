<!-- plateset#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
 -->

<@include header.tpl %>
  <div class="container">
      <h2>Plate Sets for PRJ-<%= prjid %></h2>


      
      <form id="edit_psform">
  <table id="pstable" class="table table-striped table-bordered"><thead><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>Plate Set</th><th>Name</th><th>Description</th><th>Type</th><th>Count</th><th>Format</th><th>Layout ID</th><th>Sample Replicates</th><th>Worklists</th></tr></thead>
  <tbody>  <%= body %> </tbody>
</table>

<input type="hidden" name="prjid" id="prjid" />

</form>
<br>

<hr>

<h2>Assay Runs for PRJ-<%= prjid %></h2>

<table id="artable" class="table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr></thead>
  <tbody><%= assay-runs %></tbody>
</table>



<br>
<hr>
<h2>Hit Lists for PRJ-<%= prjid %></h2>
<table id="hltable" class="table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>AR Name</th><th>Assay Type</th><th>Hit List</th><th>HL Name</th><th>Description</th><th>Number of Hits</th></tr></thead>
    <tbody>
	<%= hit-lists %>
    </tbody>
</table>


<script>   

 
 $(document).ready(function() {
     $('#pstable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     } );
 } );

 $(document).ready(function() {
     $('#artable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     } );
 } );

 $(document).ready(function() {
     $('#hltable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     } );
 } );

</script>

</div>
 
<@include footer.tpl %>
