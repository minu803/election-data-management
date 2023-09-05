<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['constituents_submit'])) {
    require_once("conn.php");
    // constituent_stats is a database view. You need to create it.
    $constituents_query = "SELECT * FROM constituent_stats;";
    try
    {
      $prepared_stmt_constituents = $dbo->prepare($constituents_query);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_constituents->execute();
      $constituents_result = $prepared_stmt_constituents->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>

<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['dem_region_submit'])) {
    require_once("conn.php");
    // dem_region_stats is a database view. You need to create it.
    $dem_region_query = "SELECT * FROM dem_region_stats;";
    try
    {
      $prepared_stmt_dem_region = $dbo->prepare($dem_region_query);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_dem_region->execute();
      $dem_region_result = $prepared_stmt_dem_region->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>



<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['dem_gender_submit'])) {
    require_once("conn.php");
    // dem_gender_stats is a database view. You need to create it.
    $dem_gender_query = "SELECT * FROM dem_gender_stats;";
    try
    {
      $prepared_stmt_dem_gender = $dbo->prepare($dem_gender_query);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_dem_gender->execute();
      $dem_gender_result = $prepared_stmt_dem_gender->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>



<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['switch_submit'])) {
    require_once("conn.php");
    // switched _election is a stored procedure that takes two inputs - party_cd 
    // and election number - 
    $switch_query = "CALL switched_election(:party, :num);";
    $var_party = $_POST['party'];
    $var_election_num = $_POST['election_num'];
    try
    {
      $prepared_stmt_switch = $dbo->prepare($switch_query);
      //bind the value saved in the variable $reg_num to the place holder :num after //verifying (using PDO::PARAM_STR) that the user has typed a valid string.
      $prepared_stmt_switch->bindValue(':party', $var_party , PDO::PARAM_STR);
      $prepared_stmt_switch->bindValue(':num', $var_election_num , PDO::PARAM_INT);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_switch->execute();
      $result_switch = $prepared_stmt_switch->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>


<html>
  <head>
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
    <h1> Analytics 1 </h1>
    <form method="post">
      <input type="submit" name="constituents_submit" value="Get Constituents Stats">
      <input type="submit" name="dem_region_submit" value="Get Dem Regional Stats"> 
      <input type="submit" name="dem_gender_submit" value="Get Dem Gender Stats">
      
      <br><br>
      Find out the number of people who switched away from <input type="text" name="party" id = "party_id"> in election <input type="text" name="election_num" id = "election_num_id">
      <input type="submit" name="switch_submit" value="Get Number of Switchers">
    </form>

    <!-- get constituents' party stats -->
    <?php
          if (isset($_POST['constituents_submit'])) {
            if ($constituents_result && $prepared_stmt_constituents->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Constituents Party Statistics</h2>
              <table>
                <thead>
                  <tr>
                    <th>Party</th>
                    <th>Count</th>
                    <th>Percentage</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($constituents_result as $constituents_row) { ?>
                
                    <tr>
                      <td><?php echo $constituents_row["party_cd"]; ?></td>
                      <td><?php echo $constituents_row["COUNT(*)"]; ?></td>
                      <td><?php echo $constituents_row["percentage"]; ?></td>
                    </tr>
                  <?php } ?>
                  <!-- End table body -->
                </tbody>
                <!-- End table -->
            </table>

            <?php } else { ?>
              <!-- IF query execution resulted in error display the following message-->
              <h3>Sorry, no results found in the database. </h3>
            <?php }
        } ?>

    <!-- get dem regional stats -->
    <?php
          if (isset($_POST['dem_region_submit'])) {
            if ($dem_region_result && $prepared_stmt_dem_region->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Democratic Party Regional Voting Statistics</h2>
              <table>
                <thead>
                  <tr>
                    <th>City</th>
                    <th>Count</th>
                    <th>Percentage</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($dem_region_result as $dem_region_row) { ?>
                
                    <tr>
                      <td><?php echo $dem_region_row["res_city_desc"]; ?></td>
                      <td><?php echo $dem_region_row["COUNT(*)"]; ?></td>
                      <td><?php echo $dem_region_row["percentage"]; ?></td>
                    </tr>
                  <?php } ?>
                  <!-- End table body -->
                </tbody>
                <!-- End table -->
            </table>

            <?php } else { ?>
              <!-- IF query execution resulted in error display the following message-->
              <h3>Sorry, no results found in the database. </h3>
            <?php }
        } ?>

     
        <!-- get dem gender stats -->
    <?php
          if (isset($_POST['dem_gender_submit'])) {

            if ($dem_gender_result && $prepared_stmt_dem_gender->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Democratic Party Gender Voting Statistics</h2>
              <table>
                <thead>
                  <tr>
                    <th>Gender</th>
                    <th>Count</th>
                    <th>Percentage</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($dem_gender_result as $dem_gender_row) { ?>
                
                    <tr>
                      <td><?php echo $dem_gender_row["sex_code"]; ?></td>
                      <td><?php echo $dem_gender_row["COUNT(sex_code)"]; ?></td>
                      <td><?php echo $dem_gender_row["percentage"]; ?></td>
                    </tr>
                  <?php } ?>
                  <!-- End table body -->
                </tbody>
                <!-- End table -->
            </table>

            <?php } else { ?>
              <!-- IF query execution resulted in error display the following message-->
              <h3>Sorry, no results found in the database. </h3>
            <?php }
        } ?>

     
 <!-- get switched voter number-->
      <?php
          if (isset($_POST['switch_submit'])) {

            if ($result_switch) { 
                 foreach ($result_switch as $row_switch) { ?>
                   <table>
                    <tr>
                      <td><?php echo $row_switch["count"]; ?></td>
                       
                    </tr>
                    </table>
                  <?php
                 }
                }
        } ?>
    
  </body>
</html>


