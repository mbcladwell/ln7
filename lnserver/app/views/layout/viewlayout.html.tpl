<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
          
          
           -->
  
<@include header.tpl %>
<div class="container">
  <h1>View/Import Layout</h1><br><br>
  

<form action="updatedb?infile=">
 <label for="myfile">Continue with import of layout?:</label>
  <input type="submit" value="Yes" >  
</form> 
<form action="getall"> <input type="submit" value="Cancel"></form>  


<div class="btn-group" role="group" aria-label="mygroup">
   <label for="mygroup">Continue with import of layout?:</label>

  <button type="submit" class="btn btn-secondary" action="updatedb?infile=">Yes</button>
  <button type="submit" class="btn btn-secondary" action="getall">Cancel</button>
</div>
  
  <p><h3>Sample Layout</h3></p>

<%= spl-out2 %>
  
  </div>
<@include footer.tpl %>

