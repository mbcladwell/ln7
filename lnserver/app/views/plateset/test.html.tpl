<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Test</h1><br><br>

qstr: <%= qstr %><br>
<br>
(car qstr): <%= c %>
<br>

match-lambda c: <%= sql %>
<br>
'(plateset-id 1):<%= b %>
<br>
match-lambda b: <%= b-val %>
<br>


  
<@include footer.tpl %>

