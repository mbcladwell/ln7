<!-- plateset#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
 -->

<@include header.tpl %>
<form action="/plateset/editps?project-name$value" method="get">
<p><table><caption><h1>Plate Sets for PRJ-<%= id %></h1></caption><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>Plate Set</th><th>Name</th><th>Description</th><th>Type</th><th>Count</th><th>Format</th><th>Layout ID</th></tr>
  <%= body %>
</table></p>
<dev>
<p>
  <input type="radio" id="group" name="buttons" value="group" onchange="getpsSelection(event)"><label for="group">Group</label></p>
 <p> <input type="radio" id="reformat" name="buttons" value="reformat" onchange="getpsSelection(event)"><label for="reformat">Reformat</label></p>
<p> <input type="radio" id="importradio" name="buttons" value="importradio" onchange="getpsSelection(event)"><label for="importradio">Import</label>
    <select name="import" id="import" onchange="getpsSelection(event)">
 <option value="data">Assay data</option>  
  <option value="accessions">Accessions</option>
   <option value="barcodes">Barcodes</option>
     </select></p><br></p>

<p> <input type="radio" id="exportradio" name="buttons" value="exportradio" onchange="getpsSelection(event)"><label for="exportradio">Export</label>&nbsp;
    <select name="export" id="export" >
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
