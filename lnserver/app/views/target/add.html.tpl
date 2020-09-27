<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <h3>Add Target Layout</h3>

<hr>
<h3>Add Target</h3><br>
<div>
<form action="/addbulk">
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
