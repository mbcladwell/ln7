<!-- assayrun#getforpsid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  

  <table><caption><h1>Assay Run AR-<%= id %></h1></caption><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr>

  <%= body %>
</table>
<img src=<%= outfile2 %> align="left">

<div  >
<form>
<table style="table: 1px solid black;">
  <tr><th>Response:</th><th>

<select id="response">
  <option value="0">Background Subtracted</option>
  <option value="1">Normalized</option>
  <option value="2">Norm to Positive</option>
  <option value="3">% enhanced</option>
</select>

      
</th><th>Threshold:</th><th><input type="text" id="manthreshold" name="manthreshold"><br></th></tr>
  <tr><th>Algorithm:</th><th>

<select id="threshold">
  <option value="1">mean(pos)</option>
  <option value="2">mean(neg) + 2SD</option>
  <option value="3">mean(neg) + 3SD</option>
</select>

      
</th><th></th> <th><input type="submit" value="Replot"></th></tr>
    </table>
</form>
</div>
<@include footer.tpl %>
