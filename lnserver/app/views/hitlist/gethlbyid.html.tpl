<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <div class="container">
<h2>Hits for HL-<%= id %></h2>
  <table id="hltable" class="table table-striped table-bordered" ><thead><tr><th>Name</th><th>Project</th><th>Accession</th></tr></thead>
 <tbody> <%= body %></tbody>
</table>
</div>
<script>          
$(document).ready(function() {
    $('#hltable').DataTable({
	 "paging":  true,
        "ordering": true,
        "info":     true
    });
});
  

</script>


<@include footer.tpl %>
