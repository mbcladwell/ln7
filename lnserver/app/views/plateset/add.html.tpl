<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Add a Plate Set To Project PRJ-</h1><br><br>

  <form action="/plateset/addaction?name=pname$value&description=descr$value">
<p>  <label for="name">Plate Set Name:</label>  <input type="text" id="psname" name="psname" value=""></p><br>
 <p> <label for="descr">Description:</label>  <input type="text" id="descr" name="descr" value=""></p><br>
 <p> <label for="numplates">Number of Plates:</label>  <input type="text" id="numplates" name="numplates" value=""></p><br>
 
 <p> <label for="format">Plate Format:</label>
  <select name="format" id="format">
                                      <option value="96">96</option>
                                         <option value="384">384</option>
                                         <option value="1536">1536</option>
                                         </select> </p><br>
 <p> <label for="type">Plate Type:</label>
  <select name="type" id="type" onchange="typeSelection(event)"> <%= plate-types %>
                                         </select> </p><br>
 <p> <label for="sample">Sample Layout:</label> 
 <select name="sample" id="sample"> <%= sample-layouts %> </select> </p><br>
  
<p> <label for="target-layout">Target Layout:</label>
  <select name="target-layout" id="target-layout"  onchange="targetSelection(event)"> <%= target-layouts %>  </select> <label for="target-desc"><%= trg-desc %></label> </p><br>
   
  <input type="submit" value="Submit">
</form> 

<script src="addps.js"></script>
  
<@include footer.tpl %>

