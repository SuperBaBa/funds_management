<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript">
//验证码js
	var imgCode;

	$(function() {
		loadCodeImg();
		$('#codeImage').load(function() {
			setTimeout('loadImgCode()', 1000);
		});
	});

	function loadImgCode() {
		$.post("${pageContext.request.contextPath}/img/loadImgCode",
				function(code) {
					imgCode = code;
				});
	}

	function loadCodeImg() {
		$('#imgCode').textbox("setText", "");
		$('#codeImage').attr(
				'src',
				'${pageContext.request.contextPath}/img/imgCode?random='
						+ Math.random());
	}
</script>
<script type="text/javascript">
$.extend($.fn.validatebox.defaults.rules, {
	equalsImgCode : {
		validator : function(value, imgCode) {
			return value == imgCode;
		},
		message : ''
	}
});
</script>
<title>用户登录</title>
</head>
<body>
<div class="easyui-window"
		data-options="title:'用户登录',modal:true,collapsible:false,minimizable:false,maximizable:false,closable:false,draggable:false,resizable:false,iconCls:'icon-lock'"
		style="width: 350px; padding: 20px 50px 20px 50px;">
		<input id="msg" type="hidden" value="${msg}"/>
		<form id="loginForm" method="post">
			<div style="margin-bottom: 5px">
				<input id="loginame" type="text" 
					data-options="iconCls:'icon-man',prompt:'账号/手机号/身份证号',required:true"
					class="easyui-textbox"
					style="width: 100%; height: 30px; padding: 12px">
			</div>
			<div style="margin-bottom: 5px">
				<input id="userPassword" name="password"
					data-options="prompt:'密码',required:true"
					class="easyui-passwordbox"
					style="width: 100%; height: 30px; padding: 12px">
			</div>
			<div style="margin-bottom: 5px">
				<input id="imgCode" class="easyui-textbox" type="text"
					style="width: 45%; height: 30px; padding: 12px"
					data-options="prompt:'验证码',required:true,validType:'equalsImgCode[imgCode]',missingMessage:''" />
				<img id="codeImage"
					style="margin: 0 0 0 3px; vertical-align: middle; height: 26px;"
					src=""> <a onclick="loadCodeImg()" class="easyui-linkbutton"
					data-options="plain: true, iconCls:'icon-reload'">换一张</a>
			</div>
			<a name="enter"class="easyui-linkbutton" style="padding: 5px 0px; width: 100%;"
				onclick="login()"> <span style="font-size: 14px;">登录</span>
			</a>
		</form>
	</div>
</body>
</html>
<script type="text/javascript">
function login() {
		$('#loginForm').form('submit', {
			url : '${pageContext.request.contextPath}/manager/ulogin',
			onSubmit: function(){
				var isValid = $(this).form('validate');
				var phone=/^1[3-8]+\d{9}$/;
				var idNum=/^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
				var accountNum=/^\d{19}$/;
				var str=$('#loginame').val();
				if(isValid){
					if(phone.test(str)){
						$('#loginame').attr("name","phoneNumber");
						return true;
					}
					else if(idNum.test(str)){
						$('#loginame').attr("name","idNumber");
						return true;
					}else if(accountNum.test(str)){
						$('#loginame').attr("name","accountNumber");
						return true;
					}else {
							parent.$.messager.alert('提示','请输入正确的 账号/身份证号/手机号及密码');
							return false;
					}
				}else{
					parent.$.messager.alert('提示','请填写正确的验证码');
					return false;
				}
		    },    
			success : function(d) {
				if (d==1) {
					parent.window.location.href = '${pageContext.request.contextPath}/user/index';
				}else if(d==0){
					parent.$.messager.alert('提示','请输入正确的 账号/身份证号/手机号及密码');
					window.location.href = '${pageContext.request.contextPath}/manager/u_login';
				}else if(d==2){
					parent.$.messager.alert('提示','您的账号已被冻结，请联系管理员进行处理');
				}
			}
		});
	}
//回车登录
$(function(){ 
	$(document).keydown(function(event){ 
		if(event.keyCode==13){ 
			 login();
		} 
	});
	//拦截器回传的信息
	function msg(){
		var msg=null;
	if(msg!=null&&msg!=''){
		msg=$('#msg').val();
		parent.$.messager.alert('警告',msg);
	};
}
});
</script>