<?php
ini_set("include_path", '/home2/plapan/php:' . ini_get("include_path") );
// $db = new mysqli('192.254.187.215','plapan_lic_admin','welcome','plapan_license', '3306');

$conn = pg_connect("host=raja.db.elephantsql.com port=5432 dbname=klohymim user=klohymim password=hwc3v4_rbkT-1EL2KI-JBaqFq0thCXM_ connect_timeout=5");

if ($conn->connect_errno) {
    die($conn->connect_error);
}


$result = pg_query($conn, "select id , assay_run_sys_name , assay_run_name , descr from assay_run where plate_set_id IN (Select id from plate_set where project_id=1);");

$table_content = "";

while ($row = pg_fetch_array($result))
{
     $table_content = $table_content."<tr><td>".$row["id"]."</td><td>"."<tr><td>".$row["assay_run_sys_name"]."</td><td>"."<tr><td>".$row["descr"]."</td><td></tr>";
} 



pg_close($conn);


?>
<html>
<head>
        <link rel="icon" href="/images/las.png">  
<style>
body {
  background-color: #f2f2f2;
  font-family: "Arial";
}

</style>
</head>
<body>
<img src="../images/las.png">    <br>
<br><br>

<table>
     
<tr><td>ID</td><td>Name</td><td>Description</td></tr>
     
"<?php echo $table_content ?>"
                                                                                           
</table>


      
<br><br><br>
<script>


function copyPassword() {
  /* Get the text field */
  var copyText = document.getElementById("genPasswordButton");

  /* Select the text field */
  copyText.select();
  copyText.setSelectionRange(0, 99999); /*For mobile devices*/

  /* Copy the text inside the text field */
  document.execCommand("copy");

  /* Alert the copied text */
  alert("Copied the text: " + genPasswordButton);
} 

function myFunction() {
  /* Get the text field */
  var copyText = document.getElementById("myInput");

  /* Select the text field */
  copyText.select();
  copyText.setSelectionRange(0, 99999); /*For mobile devices*/

  /* Copy the text inside the text field */
  document.execCommand("copy");

  /* Alert the copied text */
  alert("Copied the text: " + myInput);
} 

function getChecked(){
    var box1 = document.getElementById("checkbox1");
}


</script>

</body>
</html>

 
