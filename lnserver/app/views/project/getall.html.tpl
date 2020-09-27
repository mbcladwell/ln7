<!-- project#getall view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
  <a href="project/add">Add Project</a>
  <form action="/project/edit?project-name$value">
<table><caption><h1>All Projects</h1></caption><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>Project</th><th>Name</th><th>Description</th></tr>
<%= body %>
</table>
 <input type="submit" value="Edit Project">
</form>
<@include footer.tpl %>

