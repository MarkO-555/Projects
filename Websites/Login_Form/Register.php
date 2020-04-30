<?php 
	$host="localhost";
	$host="localhost";
	$user="root";
	$password="";
	$db="login";

	$conn = new mysqli($host, $user, $password, $db);

	if(isset($_POST['Username']) && isset($_POST['Password'])){

		$qu = "SELECT ID, Username, Password FROM loginform";
		$result = $conn->query($qu);

		if ($result->num_rows > 0) {
			$des = 0;
			while($row = $result->fetch_assoc()) {	
				if($_POST['Username'] == $row['Username']){
					echo("Username already exists");
					$des = 1;
					break;
				}
			}
			if($des ==0){
				$str = "INSERT INTO loginform (Username,Password) VALUE ('".$_POST['Username']."','".$_POST['Password']."')";
				$conn->query($str);
			}
		}
		else{
			echo "There is no rows in this table";
		}

		$conn->close();
	}
?>

<html>
	<head>
		<title>Register</title>
	</head>
	<body>
		<form method="post">
			<h2>Register</h2>
			<span style="margin-right: 5px;">Username:</span><input type="text" name="Username"><br>
			<span style="margin-right: 9px;">Password:</span><input type="password" name="Password"><br>
			<input type="submit"><br>
			<a href="login.php">Login</a>
		</form>
	</body>
</html>