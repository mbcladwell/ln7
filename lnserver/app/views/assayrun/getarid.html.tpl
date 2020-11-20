<!-- assayrun#getforpsid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  

  <table><caption><h1>Assay Run AR-<%= id %></h1></caption>
  <tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr>

  <%= body %>
</table>
<p>
<img src=<%= outfile2 %> align="left">
</p>
<div>
<form action="replot" method="get" >
<p><tr><th>Response:</th><th>

<select id="response" name="response">
  <option value="0">Background Subtracted</option>
  <option value="1">Normalized</option>
  <option value="2">Norm to Positive</option>
  <option value="3">% enhanced</option>
</select></p><br>

<p> Threshold - algorithmic:
<select id="threshold" name="threshold">
  <option value="1">mean(pos)</option>
  <option value="2">mean(neg) + 2SD</option>
  <option value="3">mean(neg) + 3SD</option>
</select>  &nbsp;&nbsp;  OR manually enter:<input type="text" id="manthreshold" name="manthreshold">
</p>
      
<p><input type="submit" value="Replot">
  </p>  
    <input type="hidden" id="infile" name="infile" value=<%= infile %>>
    <input type="hidden" id="infile2" name="infile2" value=<%= infile2 %>>
</form>

</div>
<@include footer.tpl %>
