<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>안경전문기업 Glass 長 - 영업관리프로그램</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="img/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/css/util.css">
	<link rel="stylesheet" type="text/css" href="css/css/main.css">
<!--===============================================================================================-->
</head>
<script>
	window.history.forward(); 
	function noBack(){ window.history.forward(); }
</script>

<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<div class="back">
		<div class="limiter">
			<div class="container-login100">
				<div class="wrap-login100 p-t-50 p-b-90">
					<form action="loginCheck.jsp" method="POST" class="login100-form validate-form flex-sb flex-w">
						<span class="login100-form-title p-b-51"> Login </span>


						<div class="wrap-input100 validate-input m-b-16"
							data-validate="Username is required">
							<input class="input100" type="text" id="ID" name="ID"
								placeholder="Username"> <span class="focus-input100"></span>
						</div>


						<div class="wrap-input100 validate-input m-b-16"
							data-validate="Password is required">
							<input class="input100" type="password" id="PW" name="PW"
								placeholder="Password"> <span class="focus-input100"></span>
						</div>


						<div class="container-login100-form-btn m-t-17">
							<input type="submit" id="loginBtn" class="login100-form-btn" value="login" />
						</div>
						
					</form>
					
					<div class=" signUp">
						<span class="txt1">Glass 長</span>
					</div>
				</div>
											

			</div>
		</div>
	</div>

	<!-- div id="dropDownSelect1"></div-->
	
<!--===============================================================================================-->
	<script src="vendor/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>
