<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Expires" CONTENT="0"> 
<meta http-equiv="Cache-Control" CONTENT="no-cache"> 
<meta http-equiv="Pragma" CONTENT="no-cache"> 
<title>银行资金账户管理系统</title>
<!-- 引入JQuery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5.5.4/jquery.min.js"></script>
<!-- 引入EasyUI -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5.5.4/jquery.easyui.min.js"></script>
<!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5.5.4/locale/easyui-lang-zh_CN.js"></script>
<!-- 引入EasyUI的样式文件-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/jquery-easyui-1.5.5.4/themes/bootstrap/easyui.css"
	type="text/css" />
<!-- 引入EasyUI的图标样式文件-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/jquery-easyui-1.5.5.4/themes/icon.css"
	type="text/css" />
</head>
<body class="easyui-layout">
	<!-- top布局 -->
	<div data-options="region:'center'"
		style="padding: 5px; background: #eee;">

		<p>Select your role entry in this window.</p>
		<div id="w" class="easyui-window" title="入口"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 300px; padding: 10px;">
			<h2 align="center">Welcome to this system</h2>
			<h2 align="center">欢迎使用本系统</h2>
			<b style="font-size: 14px;"><p>&nbsp;&nbsp;&nbsp;&nbsp;请选择系统入口：</p></b>
			<table border="0" cellspacing="" cellpadding="" style="width: 50%"
				align="center">
				<tr></tr>
				<tr>
					<td align="center" valign="middle"><a href="manager/a_login"
						class="easyui-linkbutton" data-options="plain:true" iconCls="icon-lock"><h3>管理员</h3></a>
					</td>
					<td align="center" valign="middle"><a href="manager/u_login"
						class="easyui-linkbutton" data-options="plain:true" iconCls="icon-man"><h3>用&nbsp;&nbsp;户</h3></a>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	$(document).ready(function() {
		$('#w').window('open')
	});
</script>


