<!-- project#edit view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Edit Project PRJ-<%= id %></h1><br><br>


  <form action="/project/editaction?id=id$value&name=pname$value&description=descr$value">
  <label for="name">Project Name:</label>  <input type="text" id="pname" name="pname" value= <%= name %> ><br>
  <label for="descr">Description:</label>  <input type="text" id="descr" name="descr" value= <%= descr %> ><br><br>
  <input type="submit" value="Submit">
  <p style="visibility: hidden;">
 <input type="text" id="id" name="id" value= <%= id %> >
   </p>
</form> 


  
<@include footer.tpl %>

