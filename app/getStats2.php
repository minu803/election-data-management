


<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['custom1_submit'])) {
    require_once("conn.php");
    $custom1_query = "SELECT * FROM dem_generation;";
    try
    {
      $prepared_stmt_custom1 = $dbo->prepare($custom1_query);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_custom1->execute();
      $custom1_result = $prepared_stmt_custom1->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>



<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['custom2_submit'])) {
    require_once("conn.php");
    $custom2_query = "SELECT * FROM race_party_stats;";
    try
    {
      $prepared_stmt_custom2 = $dbo->prepare($custom2_query);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_custom2->execute();
      $custom2_result = $prepared_stmt_custom2->fetchAll();
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
    <h1> Analytics 2 </h1>
    <form method="post">
      
      <input type="submit" name="custom1_submit" value="Custom1 Stats">
      <input type="submit" name="custom2_submit" value="Custom2 Stats">
    </form>

    <!-- get constituents' party stats -->
    

    <!-- get dem regional stats -->
    

     <!-- get rep regional stats-->
    <?php
          if (isset($_POST['custom1_submit'])) {

            if ($custom1_result && $prepared_stmt_custom1->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Democratic Party Preference by Generation</h2>
              <table>
                <thead>
                  <tr>
                    <th>Party</th>
                    <th>Generation</th>
                    <th>Count</th>
		    <th>Percentage</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($custom1_result as $custom1_row) { ?>
                
                    <tr>
                      <td><?php echo $custom1_row["party_cd"]; ?></td>
		      <td><?php echo $custom1_row["age_range"]; ?></td>
                      <td><?php echo $custom1_row["count"]; ?></td>
                      <td><?php echo $custom1_row["percentage"]; ?></td>
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
    

     <!-- get rep gender stats-->
    <?php
          if (isset($_POST['custom2_submit'])) {

            if ($custom2_result && $prepared_stmt_custom2->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Party Affiliation among African Americans</h2>
              <table>
                <thead>
                  <tr>
                    <th>Race</th>
                    <th>Party</th>
		    <th>Count</th>
                    <th>Percentage</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($custom2_result as $custom2_row) { ?>
                
                    <tr>
                      <td><?php echo $custom2_row["race_code"]; ?></td>
                      <td><?php echo $custom2_row["party_cd"]; ?></td>
		      <td><?php echo $custom2_row["count"]; ?></td>
                      <td><?php echo $custom2_row["percentage"]; ?></td>
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
      
    
  </body>
</html>


