<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['name_submit']) || isset($_POST['history_submit'])
||isset($_POST['demo_submit']) ) {
    // Refer to conn.php file and open a connection.
    require_once("conn.php");
    // Will get the value typed in the form text field and save into variable
    $var_reg_num = $_POST['reg_num'];
    // Save the query into variable called $query. Note that :num is a place holder
    // The following procedure should accept voting registration number 
    //and then return the election ID, Voting MEthod and voted party.
    $name_query = "SELECT full_name_mail FROM voter WHERE voter_reg_num = :num;";
    $history_query = "CALL GetHistory(:num)";


try
    {
      // Create a prepared statement. Prepared statements are a way to eliminate SQL INJECTION.
      $prepared_stmt_name = $dbo->prepare($name_query);
      $prepared_stmt_history = $dbo->prepare($history_query);
      //bind the value saved in the variable $var_reg_num to the place holder :num
      // Use PDO::PARAM_STR to sanitize user string.
      $prepared_stmt_name->bindValue(':num', $var_reg_num, PDO::PARAM_STR);
      
      $prepared_stmt_history->bindValue(':num', $var_reg_num, PDO::PARAM_STR);
      $prepared_stmt_name->execute();
      $prepared_stmt_history->execute();
      // Fetch all the values based on query and save that to variable $result
      $name_result = $prepared_stmt_name->fetchAll();
      $history_result = $prepared_stmt_history->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}


?>
<!-- get voter name result -->
<html>
<!-- Any thing inside the HEAD tags are not visible on page.-->
  <head>
    <!-- THe following is the stylesheet file. The CSS file decides look and feel -->
    <link rel="stylesheet" type="text/css" href="project.css" />
  </head> 
<!-- Everything inside the BODY tags are visible on page.-->
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
    
    <h1> Search Voter/Voting History by Voter Registration Number</h1>
    <!-- This is the start of the form. This form has one text field and one button.
      See the project.css file to note how form is stylized.-->
    <form method="post">

      <label for="id_reg_num">Please type the Voter Registration Number</label>
      <input type="text" name="reg_num" id = "id_reg_num">
      <br><br>
      <!-- get name button  -->
      <input type="submit" name="name_submit" value="Get Name">
      
      <!-- get history button  -->
      <input type="submit" name="history_submit" value="Get Voting History">



    </form>
    <?php
      if (isset($_POST['name_submit'])) {
        // If the query executed (result is true) and the row count returned from the query is greater than 0 then...
        if ($name_result && $prepared_stmt_name->rowCount() > 0) { ?>
              <!-- first show the header RESULT -->
              <h2>Full name of voter registration number <?php echo $_POST['reg_num']; ?></h2>

              <?php foreach ($name_result as $name_row) { ?>
               <?php echo $name_row["full_name_mail"]; ?>
               <?php } ?>

        <?php } else { ?>
          <!-- IF query execution resulted in error display the following message-->
          <h3>Sorry, no results found for voter <?php echo $_POST['reg_num']; ?>. </h3>
        <?php }
    } ?>

<!-- get voter history form -->
    <?php
          if (isset($_POST['history_submit'])) {
            // If the query executed (result is true) and the row count returned from the query is greater than 0 then...
            if ($history_result && $prepared_stmt_history->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Voting history of voter registration number <?php echo $_POST['reg_num']; ?></h2>
              <!-- THen create a table like structure. See the project.css how table is stylized. -->
              <table>
                <!-- Create the first row of table as table head (thead). -->
                <thead>
                   <!-- The top row is table head with four columns named -->
                  <tr>
                    <th>Election ID</th>
                    <th>Voting Method</th>
                    <th>Party</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                   <!-- For each row saved in the $result variable ... -->
                  <?php foreach ($history_result as $history_row) { ?>
                
                    <tr>
                      <td><?php echo $history_row["election_ID"]; ?></td>
                      <td><?php echo $history_row["voting_method"]; ?></td>
                      <td><?php echo $history_row["party_cd"]; ?></td>
                    </tr>
                  <?php } ?>
                  <!-- End table body -->
                </tbody>
                <!-- End table -->
            </table>

            <?php } else { ?>
              <!-- IF query execution resulted in error display the following message-->
              <h3>Sorry, no results found for voter <?php echo $_POST['reg_num']; ?>. </h3>
            <?php }
        } ?>




  </body>
</html>






