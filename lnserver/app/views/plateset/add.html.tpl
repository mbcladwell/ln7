<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Add a Plate Set</h1><br><br>

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
 <p> <label for="format">Plate Type:</label>
  <select name="format" id="format">
                                      <option value="assay">assay</option>
                                         <option value="rearray">rearray</option>
                                         <option value="master">master</option>
                                         <option value="daughter">daughter</option>
                                         <option value="archive">archive</option>
                                         <option value="replicate">replicate</option>
                                         </select> </p><br>
 <p> <label for="sample">Sample Layout:</label> 
 <select name="format" id="format"> <%= sample-layouts %>
                                      
                                         </select> </p><br>
  </p><br>
 <p> <label for="target">Target Layout:</label> <select name="format" id="format">
                                     <%= target-layouts %>
                                         </select> </p><br>
  </p><br>
 
  <input type="submit" value="Submit">
</form> 


  
<@include footer.tpl %>

