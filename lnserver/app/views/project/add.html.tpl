<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Add a Project</h1><br><br>

  <form action="/project/addaction?name=pname$value&description=descr$value">
<p>  <label for="name">Project Name:</label>  <input type="text" id="pname" name="pname" value=""></p><br>
 <p> <label for="descr">Description:</label>  <input type="text" id="descr" name="descr" value=""></p><br><br>
  <input type="submit" value="Submit">
</form> 


  
<@include footer.tpl %>

