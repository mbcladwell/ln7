<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>View/Import Layout</h1><br><br>
  
  
  <p><h3>Sample Layout</h3></p>
<img src=<%= spl-out2 %> >


<form action="updatedb?infile="<%= infile %>>



 <label for="myfile">Continue with import of layout?:</label>
  <input type="submit" value="Yes" >  
</form> 
<form action="getall"> <input type="submit" value="Cancel"></form>  
  
<@include footer.tpl %>

