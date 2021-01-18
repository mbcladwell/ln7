<!-- login#auth view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <div class="container">
    <h1>Login</h1>
    
  <p style="color:red"><%= login-failed %></p><br>
  
  <label for="content1">You are attempting to reach a page that could modify the database.</label><br>
  <label for="content2">This is not allowed in this browse only version of LIMS*Nucleus.</label><br>
  <label for="content3">Contact <a href="mailto:info@labsolns.com">Laboratory Automation Solutions</a> for options that will allow a more thorough evaluation.</label>

  <form action="/auth" method="post" >
    
      <label for="lnuser">Username:</label><input type="text" class="form-control"  id="lnuser" name="lnuser">
      <label for="passwd">Password:</label><input type="password" class="form-control"  id="passwd" name="passwd"> 
  <div class="form-row">
   <label for="submit"></label><input type="submit"  class="btn btn-primary" value="Submit">
</div>
    </form>


    </div>
    <@include footer.tpl %>
