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
<div>
 <label for="myfile">Select a layout file for import.</label><br>
 <label for="myfile">The file must contain 96, 384, or 1536 rows of data.</label>
</div>

<div class="custom-file">
  <input type="file" accept=".txt" class="custom-file-input" id="myfile" name="myfile">
  <label class="custom-file-label" for="myfile">Choose file</label>
</div>
<br><br>
<div><button type="submit" class="btn btn-primary">Submit</button>
</div>


  </form> 






  
<script src="select.js"></script>
  
  
<@include footer.tpl %>

