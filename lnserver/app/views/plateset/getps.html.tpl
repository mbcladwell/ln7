<!-- plateset#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
<@include header.tpl %>
<table><caption><h1>Plate Sets for PRJ-<%= id %></h1></caption><tr><th>Project</th><th>Name</th><th>Description</th></tr>
  <%= body %>
</table>

<hr>

<table><caption><h1>Assay Runs for PRJ-<%= id %></h1></caption><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr>
<%= assay-runs %>
  
</table>

<hr>

<table><caption><h1>Hit Lists for PRJ-<%= id %></h1></caption><tr><th>Assay Run</th><th>AR Name</th><th>Assay Type</th><th>Hit List</th><th>HL Name</th><th>Description</th><th>Number of Hits</th></tr>
<%= hit-lists %>
  
</table>

<@include footer.tpl %>
