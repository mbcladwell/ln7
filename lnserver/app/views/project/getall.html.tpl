<!-- project#getall view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
  <br>
  <h1>All Projects</h1>
  <form action="/project/edit" id="edit_form">
<table id="prjtable" class="table table-bordered table-striped"><thead><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>Project</th><th>Name</th><th>Description</th></tr></thead><tbody>
    <%= body %>
    </tbody>
</table>

  </form>

<script>
  $(document).ready(function() {
    $('#prjtable').DataTable();
} );
</script>

  <@include footer.tpl %>

