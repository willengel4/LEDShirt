<?php
    include 'sql_interface.php';
    $in = $_GET['in'];
    
    $f = fopen("out.txt", "w");

    fwrite($f, $in);
    fclose($f);

    /* Check if the userName already exists */
    //$updateCmd = "update shirt set str='$in';";
    //$updateRes = query_database($updateCmd);

    //echo "$updateCmd";
?>