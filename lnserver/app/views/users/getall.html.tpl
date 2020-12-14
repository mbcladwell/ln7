<!-- project#getall view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
  
  <h2>All Users</h2>
<table id="userstable" class="display table table-striped table-bordered"><thead><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>ID</th><th>Group</th><th>Name</th></tr></thead>
<tbody><%= body %></body>
</table>

  <script>          
$(document).ready(function() {
    $('#userstable').DataTable()});

</script>

<@include footer.tpl %>

