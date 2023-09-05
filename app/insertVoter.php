<?php

if (isset($_POST['f_submit'])) {

    require_once("conn.php");

    $var_reg_num = $_POST['f_reg_num'];
    $var_first_name = $_POST['f_first_name'];
    $var_middle_name = $_POST['f_middle_name'];
    $var_last_name = $_POST['f_last_name'];
    $var_suffix = $_POST['f_suffix'];    
    $var_party = $_POST['f_party'];

    $query = "CALL insert_voter(:reg_num, :first_name, :middle_name, :last_name, :suffix, :party, @msg);";

    try
    {
      $prepared_stmt = $dbo->prepare($query);

      $prepared_stmt->bindValue(':reg_num', $var_reg_num, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':first_name',  $var_first_name, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':middle_name',  $var_middle_name, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':last_name',  $var_last_name , PDO::PARAM_STR);
      $prepared_stmt->bindValue(':suffix',  $var_suffix, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':party',  $var_party, PDO::PARAM_STR);

      $prepared_stmt->execute();

      $result = $prepared_stmt->fetchAll();

    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}

?>

<html>
  <head>
    <!-- THe following is the stylesheet file.  -->
    <link rel="stylesheet" type="text/css" href="project.css" />
  </head> 

  <body>
    <div id="navbar">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="getVoter.php">Search Voter</a></li>
        <li><a href="insertVoter.php">Register Voter</a></li>
        <li><a href="deleteVoter.php">Delete Voter</a></li>
        <li><a href="getStats.php">Analytics 1</a></li>
        <li><a href="getStats2.php">Analytics 2</a></li>
      </ul>
    </div>

<h1> Register a New Voter </h1>

    <form method="post">
    	<label for="id_mID">Voter Registration Number</label>
    	<input type="text" name="f_reg_num" id="id_reg_num"> 

    	<label for="id_title">First Name</label>
    	<input type="text" name="f_first_name" id="id_first_name">
      
    	<label for="id_director">Middle Name</label>
    	<input type="text" name="f_middle_name" id="id_middle_name">

    	<label for="id_year">Last Name</label>
    	<input type="text" name="f_last_name" id="id_last_name">

    	<label for="id_director">Suffix</label>
    	<input type="text" name="f_suffix" id="id_suffix">

    	<label for="id_director">Party</label>
    	<input type="text" name="f_party" id="id_party">
    	
    	<input type="submit" name="f_submit" value="Submit">
    </form>


     <?php
      if (isset($_POST['f_submit'])) { 
        foreach ($result as $row){
          echo $row["msg"];
        }
    } ?> 
</html>