<!-- project#getall view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <div class="container">
  <h1>All Sessions</h1>
<table id="sesstable"><thead><tr><th>Session</th><th>Name</th><th>Group</th><th>Expires</th></tr></thead>
<tbody><%= body %></tbody>
</table>

Active sessions in <font style="color:red">red</font><br><br>
</div>

  <script>          
$(document).ready(function() {
    $('#sesstable').DataTable()});

</script>

<@include footer.tpl %>

