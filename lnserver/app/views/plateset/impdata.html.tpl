<!-- 
   select.js puts an event listener on "myfile" and validates the file
Then submit must be pressed to process
   <input type="hidden" id="" name="outfile" value=  >
           -->

<@include header.tpl %>
  <div class="container">
    <h2>Select Data File For Import into PS-</h2><br>

    <form action="/impdataaction" method="POST">
      <div>
	<label for="myfile">Select a data file for import.</label><br>
	<label for="myfile">The file must be tab delimitted text with a header and contain a multiple of 96 rows of data.</label><br>
	<label for="myfile">Required format:</label>
      </div>

      <pre>plate	well	response
1	1	0.0169565720739546
1	2	0.0851872146156393
1	3	0.354537624810057
1	4	0.225453937471582
1	5	0.192274022164301 ....</pre>
      
      <div class="custom-file">
	<input type="file" accept=".txt" class="custom-file-input" id="myfile" name="myfile">
	<label class="custom-file-label" for="myfile">Choose file</label>
      </div><br><br>
      <button type="submit" class="btn btn-primary">Submit</button><br>      
      <input type="hidden" id="datatransfer" name="datatransfer" >
      <input type="hidden" id="format2" name="format2" >
    </form>

    <span id="myText"></span>
     

    <script>
      $('#myfile').on('change',function(){
          //get the file name
          var fileName = $(this).val();
          //replace the "Choose a file" label
          $(this).next('.custom-file-label').html(fileName);
      })
    </script>

</div>
  
<script src="impdata.js"></script>
  
  
<@include footer.tpl %>

