<!-- login#auth view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

 <@include header.tpl %>
    <h1>Login</h1>
    
  <p style="color:red"><%= login-failed %></p><br>
  
  
    <p>You are attempting to reach a page that could modify the database.<br>
      This is not allowed in this browse only version of LIMS*Nucleus.<br>
      Contact <a href="mailto:info@labsolns.com">Laboratory Automation Solutions</a> for options that will allow a more thorough evaluation.</p><br>
    
    <form action="/auth" method="post" >
      <p><label for="lnuser">Username:</label><input type="text" id="lnuser" name="lnuser"></p><br>
      <p><label for="passwd">Password:</label><input type="password" id="passwd" name="passwd"></p>     
      <p> <label for="submit2"></label><input type="submit" value="Submit"></p>
    </form>

    <@include footer.tpl %>
