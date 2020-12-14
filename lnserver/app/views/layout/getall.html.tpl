<!-- layout#getall view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
<@include header.tpl %>
  
  <h2>Plate Layouts</h2>
<table id="lyttable" class="display table table-striped table-bordered"><thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Format</th><th>Sample N</th><th>Target N</th><th>Edge?</th><th>N Controls</th><th>Unk N</th><th>Location</th><th>src/dest</th></tr></thead>
  <tbody><%= body %></tbody>
</table>

  <script>          
$(document).ready(function() {
    $('#lyttable').DataTable()});

</script>

<@include footer.tpl %>
