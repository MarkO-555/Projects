<?php 
	$host="localhost";
	$user="root";
	$password="";
	$db="login";

	$conn = new mysqli($host, $user, $password, $db);

	if(isset($_POST['Username']) && isset($_POST['Password'])){
		

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