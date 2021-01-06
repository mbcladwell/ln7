<!-- plate#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <div class="container">
    <h2>Plates for PS-<%= id %></h2>
<table class="display table table-striped table-bordered"><thead><tr><th>Plate</th><th>Plate Type</th><th>Barcode</th></tr></thead>
 <tbody> <%= body %></tbody>
</table>
<hr>
<h2>Assay Runs for PS-<%= id %></h2>
<table class="display table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr></thead>
<tbody> <%= body2 %></tbody>
</table>
<hr>
<h2>Hit Lists for PS-<%= id %></h2>
<table class="display table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>Hit List</th><th>Name</th><th>Description</th><th>N</th></tr></thead>
 <tbody><%= body3 %></tbody>
  </table>

<script>          
$(document).ready(function() {
    $('table.display').DataTable();
} );

</script>


<@include footer.tpl %>
