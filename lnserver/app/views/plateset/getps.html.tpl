<!-- plateset#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
 -->

<@include header.tpl %>
  <a href="/plateset/add?format=96&type=master">Add Plate Set</a>
<form action="/plateset/editps" method="post">
<p><table><caption><h1>Plate Sets for PRJ-<%= id %></h1></caption><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>Plate Set</th><th>Name</th><th>Description</th><th>Type</th><th>Count</th><th>Format</th><th>Layout ID</th><th>Sample Replicates</th></tr>
  <%= body %>
</table><br>
<dev>
  <p>
  <input type="radio" id="edit" name="buttons" value="edit" onchange="getpsSelection(event)"><label for="edit">Edit</label><label>&nbsp(name or description)</label></p><br>
    
 <p> <input type="radio" id="group" name="buttons" value="group" onchange="getpsSelection(event)"><label for="group">Group</label><label>(2 or more Plate Sets of the same format and layout)</label></p>
 <p> <input type="radio" id="reformat" name="buttons" value="reformat" onchange="getpsSelection(event)"><label for="reformat">Reformat</label><label>&nbsp(a single Plate Set)</label></p>
<p> <input type="radio" id="importradio" name="buttons" value="importradio" onchange="getpsSelection(event)"><label for="importradio">Import</label>
    <select name="imp" id="imp" onchange="getpsSelection(event)">
 <option value="data">Assay data</option>  
  <option value="accessions">Accessions</option>
   <option value="barcodes">Barcodes</option>
     </select></p><br><br>

<p> <input type="radio" id="exportradio" name="buttons" value="exportradio" onchange="getpsSelection(event)"><label for="exportradio">Export</label>&nbsp;
    <select name="exp" id="exp" >
 <option value="selected">Selected rows this table</option>  
  <option value="under">Underlying data</option>
     </select></p><br> </p>
  </dev>
 <input type="submit" value="Submit">
</form>
<br>
<p><img src="../img/separator.png" height="10" width="600" style="float:left"></p>

<table><caption><h1>Assay Runs for PRJ-<%= id %></h1></caption><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr>
<%= assay-runs %>
  
</table>
<br>
<p><img src="../img/separator.png" height="10" width="600" style="float:left"></p>

<table><caption><h1>Hit Lists for PRJ-<%= id %></h1></caption><tr><th>Assay Run</th><th>AR Name</th><th>Assay Type</th><th>Hit List</th><th>HL Name</th><th>Description</th><th>Number of Hits</th></tr>
<%= hit-lists %>
  
</table>

 <script src="getps.js"></script> 


<@include footer.tpl %>
