<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Add a User</h1><br><br>

  <form action="/users/addaction?name=uname$value&tags=tags$value&pw=pw$value&group=group$value">
  <label for="name">User Name:</label>  <input type="text" id="uname" name="uname" value=""><br>
  <label for="tags">Tags:</label>  <input type="text" id="tags" name="tags" value=""><br>
  <label for="pw">Password:</label>  <input type="text" id="pw" name="pw" value=""><br>
  <label for="group">Group:</label>  <select name="group" id="group">
  <option value="1">Administrator</option>
  <option value="2">User</option>
</select><br>
  <input type="submit" value="Submit">
</form> 


  
<@include footer.tpl %>

