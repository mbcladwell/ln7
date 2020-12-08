<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Group Plate Sets</h1><br><br>

  <form action="/plateset/createbygroup" method="post">

<p><label>Date:</label> &nbsp<%= today %></p><br>
<p><label>Owner:</label> &nbsp </p><br>

    <p>  <label for="name">New Plate Set Name:</label>  <input type="text" id="psname" name="psname" value=""></p><br>
 <p> <label for="descr">New Plate Set Description:</label>  <input type="text" id="descr" name="descr" value=""></p><br>

<p> <label for="psid-num">Plate Set ID (# plates):</label> &nbsp<%= ps-num-text %></p><br>

<p> <label for="tot-pl">Total number of plates:</label>&nbsp&nbsp<%= tot-plates %></p><br>
<input type="hidden" id="totplates" name="totplates" value=<%= tot-plates %>>
    
      <p> <label for="type">Plate Type:</label>
  <select name="type" id="type" onchange="typeSelection(event)"> <%= plate-types %>
                                         </select> </p><br>

<p> <label for="format">Plate Format:</label><%= format %></p><br>
<input type="hidden" id="format" name="format" value=<%= format %>>

<p> <label for="sample">Sample Layout:</label> <%= lyt-txt %></p><br>

<input type="hidden" id="lytid" name="lytid" value=<%= lyt-id %>>

<input type="submit" value="Confirm and submit">
</form> 

  
<@include footer.tpl %>

