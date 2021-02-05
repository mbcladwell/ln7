<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
  <head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="alternate" type="application/atom+xml" title="Atom 1.0" href="atom/1" />

 <link rel="stylesheet" type="text/css" media="screen" href="../css/navbar.css" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4-4.1.1/jq-3.3.1/jszip-2.5.0/dt-1.10.23/b-1.6.5/b-flash-1.6.5/b-html5-1.6.5/b-print-1.6.5/fh-3.1.7/datatables.min.css"/>



 <script type="text/javascript" charset="utf8" src="../js/clipboard.min.js"></script>
 <script type="text/javascript" charset="utf8" src="../js/menufunctions.js"></script>
<script  type="text/javascript" src="../js/js.cookie.min.js"></script>     	


 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/bs4-4.1.1/jq-3.3.1/jszip-2.5.0/dt-1.10.23/b-1.6.5/b-flash-1.6.5/b-html5-1.6.5/b-print-1.6.5/fh-3.1.7/datatables.min.js"></script>


    <title>LIMS*Nucleus </title>
    

    </head>
    <body>
    
    
    <!-- Side navigation -->
   
<div class="wrapper">
  <nav id="sidebar">

 <div class="sidebar-header">
   <h3>Laboratory Automation Solutions</h3>
   <img src="../img/las-walpha.png" alt="Laboratory Automation Solutions" style="width:140px;height:100px;">
  </div>
 <ul>
    <li class="active">
                <a href="#projectSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Projects</a>
                <ul class="collapse list-unstyled" id="projectSubmenu">
                    <li>
                        <a href="/project/getall">All</a>
                    </li>
                    <li>                    
		      <a href="#" onclick="editProject()">Edit</a>
                    </li>
                    <li>
                        <a href="/project/add">Add</a>
                    </li>
                </ul>
            </li>
    <li class="active">
                <a href="#platesetSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Plate Sets</a>
                <ul class="collapse list-unstyled" id="platesetSubmenu">
                    <li>
                        <a href=<%= get-ps-link %>>for PRJ-<%= prjid %></a>
                    </li>
                    <li>                    
		      <a href=<%= ps-add-link %>>Add to PRJ-<%= prjid %></a>
                    </li>
                    <li>                    
		      <a href="#" onclick="editPlateSet()">Edit</a>
                    </li>
                    <li>
                        <a href="#" onclick="groupPlateSet()" >Group</a>
                    </li>
                    <li>
                        <a href="#"  onclick="reformatPlateSet()">Reformat</a>
                    </li>


   <li class="active">
                <a href="#importPlatesetSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Import</a>
                <ul class="collapse list-unstyled" id="importPlatesetSubmenu">

		    
		    <li>
                        <a href="#" onclick="importPlateSetData()">Assay Data</a>
                    </li>
		    <li>
                        <a href="/plateset/impacc">Accessions</a>
                    </li>
		    <li>
                        <a href="/plateset/impbc">Barcodes</a>
                    </li>


		</ul>
   </li>

   <li class="active">
                <a href="#exportPlatesetSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Export</a>
                <ul class="collapse list-unstyled" id="exportPlatesetSubmenu">

		    
		    <li>
                        <a href="/project/add">Selected Rows</a>
                    </li>
		    <li>
                        <a href="/project/add">Underlying Data</a>
                    </li>

		</ul>
   </li>

   

                </ul>
            </li>
   
    <li class="active">
                <a href="#layoutSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Layouts</a>
                <ul class="collapse list-unstyled" id="layoutSubmenu">
                    <li>
                        <a href="/layout/getall">All</a>
                    </li>
                    <li>                    
		      <a href="/layout/select">Import</a>
                    </li>
                </ul>
            </li>
   
     <li class="active">
                <a href="#targetSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Targets</a>
                <ul class="collapse list-unstyled" id="targetSubmenu">
                    <li>
                        <a href="/target/gettrglyt">All Target Layouts</a>
                    </li>
                    <li>                    
		      <a href="/target/addtrglyt">Add Target Layout</a>
                    </li>
                    <li>
                        <a href="/target/getall">All Targets</a>
                    </li>

		    <li class="active">
                      <a href="#trgaddSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Add Target</a>
                      <ul class="collapse list-unstyled" id="trgaddSubmenu">		    
			<li>
                          <a href="/target/addsingle">Single</a>
			</li>
			<li>
                          <a href="/target/addbulk">Bulk</a>
			</li>
		      </ul>
		    </li>		    
                </ul>
            </li>
   <li class="active">
                <a href="#utilsSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Utilities</a>
                <ul class="collapse list-unstyled" id="utilsSubmenu">
                    <li>
                        <a href="../utilities/register">Register</a>
                    </li>
                    <li>                    
		      <a href="../sessions/getall" >Sessions</a>
                    </li>
		    <li class="active">
                      <a href="#usersSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Users</a>
                      <ul class="collapse list-unstyled" id="usersSubmenu">
   
			<li>
                          <a href="../users/getall">All Users</a>
			</li>
			<li>
                          <a href="../users/add">Add User</a>
			</li>

		      </ul>
		    </li>
                </ul>
            </li>
  
     
 <li class="active"> <a href="http://www.labsolns.com/software/<%= help-topic %> ">HELP</a></li>
  <li class="active"><a href="../help/toc">TOC</a></li>
  <li class="active"><a href="mailto:info@labsolns.com">Contact</a></li>
</ul>
  </nav>

  

<div id="content">

