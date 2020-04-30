<?php 
	$host="localhost";
	$user="root";
	$password="";
	$db="login";

	$conn = new mysqli($host, $user, $password, $db);

	if(isset($_POST['Username']) && isset($_POST['Password'])){

		$qu = "SELECT ID, Username, Password FROM loginform";
		$result = $conn->query($qu);

		if ($result->num_rows > 0) {
			$res = "";
			while($row = $result->fetch_assoc()) {				
				if($_POST['Username'] == $row['Username'] && $_POST['Password'] == $row['Password']){
					$res = "Login Successful";
					break;
				}
				else{
					$res = "Login Unsuccessful";
				}
			}
			
			echo($res);
		}
		else{
			echo "There is no rows in this table";
		}

		$conn->close();
	}
?>

<html>
	<head>
		<title>Login</title>
	</head>
	<body>
		<form method="post">
			<h2>Sign In</h2>
			<span style="margin-right: 5px;">Username:</span><input type="text" name="Username"><br>
			<span style="margin-right: 9px;">Password:</span><input type="password" name="Password"><br>
			<input type="submit"><br>
			<a href="register.php">Register</a>
		</form>
	</body>
</html>