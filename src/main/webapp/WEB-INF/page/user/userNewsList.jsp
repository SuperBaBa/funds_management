<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 引入JQuery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5.5.4/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/newsAssets/js/jquery.bootstrap.newsbox.min.js"
	type="text/javascript"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/newsAssets/css/normalize.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/newsAssets/css/default.css">

<link
	href="${pageContext.request.contextPath}/js/newsAssets/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />

<link
	href="${pageContext.request.contextPath}/js/newsAssets/css/bootstrap-theme.min.css"
	rel="stylesheet" type="text/css" />

<link
	href="${pageContext.request.contextPath}/js/newsAssets/css/site.css"
	rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function (){
	$.ajax({
		url : '${pageContext.request.contextPath}/admin/news/queryAllList',
		dataType:'json',
		type:'post',
		data:{
			page:'1',
			rows:'10'
		},
		success:function (data){
			var html='';
			$.each(data.rows,function(i,item){
				html+='<li class="news-item">';
				html+='<table cellpadding="4">';
				html+='<tr>';
				html+='<td><img src="${pageContext.request.contextPath}/js/newsAssets/images/1.png" width="60" class="img-circle" /></td>';		
				html+='<td >'+item.newsAbstract+'<br>';	
				html+='<a href="javacript:void(0)" onclick="test(\''+item.title+'\',\''+item.context+'\')">查看更多……</a>';
				html+='</td>';		
				html+='</tr>';
				html+='</table>';
				html+='</li>';
			})
				$('#news-items').html(html); //把内容入到这个div中即完成
			$(".demo1").bootstrapNews({
				newsPerPage : 5,
				autoplay : true,
				pauseOnHover : true,
				direction : 'up',
				newsTickerInterval : 2000,
				onToDo : function() {
					//console.log(this);
				}
		
			});
		}
	});
	
});
</script>
<script type="text/javascript">
	function test(title,fileName) {
		top.showDetail(title, fileName);
	}
</script>
</head>
<body>
	<div class="panel panel-default">
		<!--<div class="panel-heading">
							<span class="glyphicon glyphicon-list-alt"></span><b>News</b>
			</div>-->
		<div class="panel-body">
			<div class="row">
				<div class="col-xs-12">
					<ul class="demo1" id="news-items">
					</ul>
				</div>
			</div>
		</div>
	</div>

</body>

</html>