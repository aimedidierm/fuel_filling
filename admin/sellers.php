<?php
ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(E_ALL);
require '../php-includes/connect.php';
require 'php-includes/check-login.php';
if(isset($_POST['save'])){
    $names=$_POST['names'];
    $email=$_POST['email'];
    $phone=$_POST['phone'];
    $address=$_POST['address'];
    $password=md5($_POST['password']);
    $machine=$_POST['machine_id'];
    $sql ="INSERT INTO seller (email,names,phone,address,machine_id,balance,password) VALUES (?,?,?,?,?,'0',?)";
    $stm = $db->prepare($sql);
    if ($stm->execute(array($email,$names,$phone,$address,$machine,$password))) {
        print "<script>alert('Seller added');window.location.assign('sellers.php')</script>";

    } else{
        echo "<script>alert('Error! try again');window.location.assign('sellers.php')</script>";
}
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>
    Admin - sellers
  </title>
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <!-- Nucleo Icons -->
  <link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="../assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="../assets/css/material-dashboard.css?v=3.0.4" rel="stylesheet" />
</head>

<body class="g-sidenav-show bg-gray-200">
<?php require 'php-includes/nav.php';?>

<div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
            <div class="card-body px-0 pb-2">
              <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Client</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Address</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Email</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Phone</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Balance</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Action</th>
                      <th class="text-secondary opacity-7"></th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php
                    $query = "SELECT * FROM seller";
                    $stmt = $db->prepare($query);
                    $stmt->execute();
                    if ($stmt->rowCount()>0) {
                        while ($rows = $stmt->fetch(PDO::FETCH_ASSOC)) {
                        $count = 1;
                    ?>
                    <tr>
                      <td>
                        <div class="d-flex px-2 py-1">
                          <div>
                            <img src="../assets/img/user.jpg" class="avatar avatar-sm me-3 border-radius-lg" alt="user1">
                          </div>
                          <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm"><?php echo $rows['names'];?></h6>
                          </div>
                        </div>
                      </td>
                      <td>
                        <p class="text-xs font-weight-bold mb-0"><?php echo $rows['address'];?></p>
                      </td>
                      <td class="align-middle text-center text-sm">
                      <p class="text-xs font-weight-bold mb-0"><?php echo $rows['email'];?></p>
                      </td>
                      <td class="align-middle text-center">
                      <p class="text-xs font-weight-bold mb-0"><?php echo $rows['phone'];?></p>
                      </td>
                      <td class="align-middle">
                      <p class="text-xs font-weight-bold mb-0"><?php echo $rows['balance'];?></p>
                      </td>
                      <td class="align-middle">
                      <form method="post"><button type="submit" class="btn btn-danger" id="<?php echo $row["id"];$sid=$rows["id"]; ?>" name="delete"><span class="glyphicon glyphicon-trash"></span> Delete</button></form>
                      </td>
                    </tr>
                    <?php
                    $count++;
                    }
                }
                if(isset($_POST['delete'])){
                    $sql ="DELETE FROM seller WHERE id = ?";
                    $stm = $db->prepare($sql);
                    if ($stm->execute(array($sid))) {
                        print "<script>alert('Seller deleted');window.location.assign('sellers.php')</script>";
            
                    } else {
                        print "<script>alert('Delete fail');window.location.assign('sellers.php')</script>";
                    }
                }
                ?>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="panel-body">
            <div class="row">
                <div class="col-lg-6">
                    <form method="post">
                        <div class="form-group">
                            <label>Names</label>
                            <input class="form-control" type="text" name="names" required>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input class="form-control" type="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input class="form-control" type="number" name="phone" required>
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input class="form-control" type="text" name="address" required>
                        </div>
                        <div class="form-group">
                            <label>Machine ID</label>
                            <input class="form-control" type="text" name="machine_id" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input class="form-control" type="password" name="password" required>
                        </div>
                        <div class="form-group">
                        <button type="submit" class="btn btn-success" name="save"><span class="glyphicon glyphicon-check"></span> Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        </div>
      </div>
  </div>
  <!--   Core JS Files   -->
  <script src="../assets/js/core/popper.min.js"></script>
  <script src="../assets/js/core/bootstrap.min.js"></script>
  <script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="../assets/js/material-dashboard.min.js?v=3.0.4"></script>
</body>

</html>