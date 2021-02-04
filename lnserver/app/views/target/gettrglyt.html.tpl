<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <div class="container">
  <h1>Target Layouts</h1>
<table id="trglyttable" class="display table table-striped table-bordered"><thead><tr><th>ID</th><th>Layout</th><th>Name</th><th>Description</th><th>Replication</th></tr></thead>
 <tbody> <%= body %></tbody>
</table>
  </div>
  <script>          
$(document).ready(function() {
    $('#trglyttable').DataTable({
        dom: 'lBfrtip',
        buttons: [
            'copy', 'csv'
        ]
   })});

</script>


<@include footer.tpl %>
