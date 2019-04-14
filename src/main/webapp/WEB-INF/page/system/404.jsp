<%@ page language="java" contentType="text/html; charset=UTF-8"  isErrorPage="true"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>404</title>
<link href="${pageContext.request.contextPath}/js/errorPage/css/bootstrap.css" rel="stylesheet">
    <!-- FONT AWESOME CSS -->
    <link href="${pageContext.request.contextPath}/js/errorPage/css/font-awesome.min.css" rel="stylesheet" />
    <!--GOOGLE FONT -->
 <link href='http://fonts.googleapis.com/css?family=Nova+Flat' rel='stylesheet' type='text/css'>
    <!-- custom CSS here -->
    <link href="${pageContext.request.contextPath}/js/errorPage/css/style.css" rel="stylesheet" />
</head>
<body>
 
   
    <div class="container">
      
          <div class="row pad-top text-center">
                 <div class="col-md-6 col-md-offset-3 text-center">
                  <h1>  What have you done? </h1>
                   <h5> Now Go Back Using Below LInk</h5> 
					<span id="error-link"></span>
                     <h2>! ERROR DELETED !</h2>
				</div>
        </div>

            <div class="row text-center">
                 <div class="col-md-8 col-md-offset-2">
                     <h3> <i  class="fa fa-lightbulb-o fa-5x"></i> </h3>
               <a onclick="goHome()" class="btn btn-primary">GO TO HOME PAGE</a> 
            
			</div>
        </div>

    </div>
    <!-- /.container -->
  
  
    <!-- 引入JQuery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5.5.4/jquery.min.js"></script>
    <!--bootstrap JavaScript file  -->
    <script src="${pageContext.request.contextPath}/js/errorPage/js/bootstrap.js"></script>
     <!--Count Number JavaScript file  -->
    <script src="${pageContext.request.contextPath}/js/errorPage/js/countUp.js"></script>
       <!--Custom JavaScript file  -->
    <script src="${pageContext.request.contextPath}/js/errorPage/js/custom.js"></script>
    <script type="text/javascript">
    function goHome(){
    	parent.window.location.href='${pageContext.request.contextPath}';
    }
    </script>
</body>
</html>