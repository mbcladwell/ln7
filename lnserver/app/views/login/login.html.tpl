<!-- login#auth view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<html>
  <head>
    <title><%= (current-appname) %>
    </title>
    

  </head>
  <body>
 
    <h1>login#login</h1>
  <%= login-failed %>
    <p>Rendered from app/views/login/login.html.tpl.</p>
    <form action="/auth" method="post" >
   <input type="text" id="lnuser" name="lnuser"><br>
   <input type="password" id="passwd" name="passwd"><br>
    <input type="submit" value="Submit">
    </form>
   
  </body>
</html>
