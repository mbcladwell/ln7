<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
 
<h3>Add Target Layout</h3><br>

<form action="/addtrglytaction" method="get">
<p>
  <label for="prj">Project:</label>
  <select name="projects" id="projects"><%= all-projects %> </select>
</p><br>
<p>
<label for="tname">Target Layout Name:</label>
 <input type="text" id="tname" name="tlytname">
</p><br>
<p>
<label for="desc">Description:</label>
<input type="text" id="desc" name="desc"> 
</p><br>
<p>
<label for="reps">Replication:</label>
  <select name="reps" id="reps" onchange="repSelection(event)">
 <option value="1">1</option>  
  <option value="2">2</option>
   <option value="4">4</option>
     </select></p><br>
     

<p><label for="t1" id="q1">Quadrant 1:</label><select name="t1" id="t1"> <%= all-targets %></select></p><br>
<p><label for="t2" id="q2">Quadrant 2:</label><select name="t2" id="t2"> <%= all-targets %></select></p><br>
<p><label for="t3" id="q3">Quadrant 3:</label><select name="t3" id="t3"> <%= all-targets %></select></p><br>
<p><label for="t4" id="q4">Quadrant 4:</label><select name="t4" id="t4"> <%= all-targets %></select></p><br>

 <div>
   <button>Submit</button>
 </div>
</form>

<script src="addtrglyt.js"></script>


<@include footer.tpl %>
