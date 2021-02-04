<!-- layout#getall view template of lnserver
     Please add your license header here.
     This file is generated automatically by GNU Artanis. -->
<@include header.tpl %>


<div class="container">  
    <h1>Plate Layouts</h1>
    
  <table id="lyttable" class="table table-striped table-bordered">
      <thead>
	  <tr><th>ID</th><th>Name</th><th>Description</th><th>Format</th><th>Sample N</th><th>Target N</th><th>Edge?</th><th>N Controls</th><th>Unk N</th><th>Location</th><th>src/dest</th></tr>
      </thead>
      <tbody>
	  <%= body %>
      </tbody>
  </table>

</div>


<script>          
 $(document).ready(function() {
     $('#lyttable').DataTable({      
         dom: 'lBfrtip',
         buttons: [
             'copy', 'csv'
         ]
     } )});
</script>

<@include footer.tpl %>
