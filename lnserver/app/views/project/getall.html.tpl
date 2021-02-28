<!-- project#getall view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
  <div class="container">
  <h1>All Projects</h1>
  <form action="/project/edit" method="get" id="edit_project_form">
<table id="prjtable" class="table table-striped table-bordered"><thead><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>Project</th><th>Name</th><th>Description</th></tr></thead><tbody>
    <%= body %>
    </tbody>
</table>

<input type="hidden" id="prjid" name="prjid" value=<%= prjidq %>>
<input type="hidden" id="sid" name="sid" value=<%= sidq %>>



  </form>
</div>
<script>
 $(document).ready(function() {
     $('#prjtable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
 })}); 
</script>

  <@include footer.tpl %>

