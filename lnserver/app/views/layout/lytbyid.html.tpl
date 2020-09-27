<!-- layout#lytbyid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
<@include header.tpl %>

  
<table><caption><h1>Plate Layouts for Source LYT-<%= id %></h1></caption><tr><th>ID</th><th>Name</th><th>Description</th><th>Format</th><th>Sample N</th><th>Target N</th><th>Edge?</th><th>N Controls</th><th>Unk N</th><th>Location</th><th>src/dest</th></tr>

  <%= body %>
</table>

<p><h3>Sample Layout</h3></p>
<img src=<%= spl-out2 %> >
<p><h3>Sample Replication</h3></p>

<img src=<%= spl-rep-out2 %> >

<p><h3>Target Replication</h3></p>

<img src=<%= trg-rep-out2 %> >




<@include footer.tpl %>
