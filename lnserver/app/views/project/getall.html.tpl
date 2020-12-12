<!-- project#getall view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
  <br>
  <caption><h1>All Projects</h1>
  <form action="/project/edit">
<table id="prjtable" class="table table-bordered table-striped"><thead><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>Project</th><th>Name</th><th>Description</th></tr></thead><tbody>
    <%= body %>
    </tbody>
</table>
 <input type="submit" value="Edit Project">
</form>

  <script>
  $(document).ready(function() {
    $('#prjtable').DataTable();
} );
</script>
  <@include footer.tpl %>

