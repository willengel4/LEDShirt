<?php
    include 'sql_interface.php';

    $f = fopen("out.txt", "r");

    echo fread($f, filesize("out.txt"))

    //$checkCommand = "select str from shirt;";
    //$r = query_database($checkCommand);

//    if($r->num_rows == 0) 
  //  {
	//echo "error";
    //}
   // else
    //{
      //  $row = $r->fetch_assoc();
	//$str = $row["str"];
	//echo "$str";
    //}
?>