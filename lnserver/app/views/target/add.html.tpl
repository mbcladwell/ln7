<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
 
<h3>Add A Single Target</h3><br>

<form action="/addsingle" method="get">
<p>
  <label for="prj">Project:</label>
  <select name="projects" id="projects"><%= all-projects %> </select>
</p><br>
<p>
<label for="tname">Target Name:</label>
 <input type="text" id="tname" name="tname">
</p><br>
<p>
<label for="desc">Description:</label>
<input type="text" id="desc" name="desc"> 
</p><br>
<p>
<label for="accs">Accession ID:</label>
<input type="text" id="accs" name="accs">
</p><br>
<br>
 <div>
   <button>Submit</button>
 </div>
</form>

<br><br>
<hr>

<h3>Bulk Target Upload</h3>
<div>
<form action="/addbulk" method="post">
 <label for="avatar">Choose bulk target upload file:</label>

<input type="file"
       id="avatar" name="avatar"
       accept=".txt, .csv">
</div>
<br>
 <div>
   <button>Submit</button>
 </div>



<@include footer.tpl %>
