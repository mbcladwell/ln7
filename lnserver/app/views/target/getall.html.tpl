<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">    
<h1>Targets</h1>
<table id="lyttable" class="table table-striped table-bordered">
    <thead><tr><th>ID</th><th>Project</th><th>Name</th><th>Description</th><th>Accession</th></tr></thead>
 <tbody> <%= body %></tbody>
</table>
</div>
 <script>          
$(document).ready(function() {
    $('#lyttable').DataTable({
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
