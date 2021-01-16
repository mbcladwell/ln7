<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <div class="container">
    <h2>Hits for HL-<%= id %></h2>
    <form action="/project/edit" method="get" id="edit_project_form">
  <table id="hltable" class="table table-striped table-bordered"><thead><tr><th>Name</th><th>Project</th><th>Accession</th></tr></thead><tbody> <%= body %></tbody>
  </table>
  </form>
</div>
<script>          
$(document).ready(function() {
    $('#hltable').DataTable()});
  
</script>


<@include footer.tpl %>
