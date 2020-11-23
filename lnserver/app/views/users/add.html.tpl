<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Add a User</h1><br><br>

  <form action="/users/addaction?name=uname$value&pw=pw$value&group=group$value">
<p>  <label for="name">User Name:</label>  <input type="text" id="uname" name="uname" value=""></p>
<p>  <label for="pw">Password:</label>  <input type="text" id="pw" name="pw" value=""></p>
<p>  <label for="group">Group:</label>  <select name="group" id="group">
                                        <option value="admin">Administrator</option>
                                         <option value="user">User</option>
                                         </select></p>
  <input type="submit" value="Submit">
</form> 


  
<@include footer.tpl %>

