<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.         
        https://www.w3schools.com/js/js_htmldom_eventlistener.asp  
   
   <input type="hidden" id="" name="outfile" value=  >
           -->

<@include header.tpl %>

  <h1>Select Layout For Import</h1><br><br>
<input type="hidden" id="format2" name="format2"  >
  <form action="/upload" method="POST" enctype="multipart/form-data">
<p>
 <label for="myfile">Select a layout file for import.</label></p>
 <p><label for="myfile">The file must contain 96, 384, or 1536 rows of data.</label>
 </p>
<input type="file" accept=".txt" id="myfile" name="myfile" > 
<input type="submit" value="Submit">
</form> 
  
<script src="/app/views/layout/select.js"></script>
  
  
<@include footer.tpl %>

