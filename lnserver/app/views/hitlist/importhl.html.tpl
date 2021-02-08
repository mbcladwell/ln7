<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>



  <div class="container">
    <h3>Import Hit List for PRJ-<%= prjid %></h3>

    Import a one column file with header:<br><br>
<pre>
id
SPL-292
SPL-285
SPL-284
SPL-283
SPL-282
SPL-281

.
.
.
</pre>

      
    <form action="/importhitsaction" method="post">
      
      <div class="custom-file">
	<input type="file" class="custom-file-input" accept=".txt, .csv" id="customFile">
	<label class="custom-file-label" for="customFile">Choose hit list file</label>
      </div><br><br>
      
      <div>
	<button  type="submit" class="btn btn-primary">Submit</button>
      </div>
      
    </form>
  </div>


<script>
  document.querySelector('.custom-file-input').addEventListener('change',function(e){
  var fileName = document.getElementById("customFile").files[0].name;
  var nextSibling = e.target.nextElementSibling
  nextSibling.innerText = fileName
})

</script>

<@include footer.tpl %>
