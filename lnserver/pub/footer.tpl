</div>
</div>

	

<script>
 var str1 = "/hitlist/forprj?prjid=";
 var str2 = <%= prjid %>;
 var res = str1.concat(str2);
 document.getElementById("hitlistforprj").href = res;


 var str3 = "/hitlist/importhl?prjid=";
 var res2 = str3.concat(str2);
 document.getElementById("hitlistimport").href = res2;


 var str4 = "/plateset/getps?id=";
 var res3 = str4.concat(str2);
 document.getElementById("getps").href = res3;

 var str5 = "/plateset/add?format=96&type=master&prjid=";
 var res4 = str5.concat(str2);
 document.getElementById("psadd").href = res4;


$(document).ready(function () {

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });

});
</script>

</body>

</html>
