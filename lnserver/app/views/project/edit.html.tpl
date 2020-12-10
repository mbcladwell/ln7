<!-- project#edit view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Edit Project PRJ-<%= prjid %></h1><br><br>


  <form action="/project/editaction">
 <p> <label for="name">Project Name:</label>  <input type="text" id="pname" name="pname" value= <%= name %> > </p><br>
  <p> <label for="descr">Description:</label>  <input type="text" id="descr" name="descr" value= <%= descr %> > </p><br>
<p>  <input id="prjid" name="prjid" type="hidden" value=<%= prjid %>>  </p>
  <input type="submit" value="Submit">
</form> 


  
<@include footer.tpl %>

