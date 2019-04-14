<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
<script>
	function submitForm() {
		$('#ff').form('submit', {
			url : '${pageContext.request.contextPath}/admin/passwordEdit',
			onSubmit: function(){ 
				if ($("input[name='newPassword']").val() == $("input[name='reNewPassword']").val()) {
					return true;
				} else {
					parent.$.messager.alert('警告', '两次密码不匹配');
					return false;
				} 
		    },    
			success : function(d) {
				if (d==1) {
					var time=setInterval (showTime, 1000);
					var second=3;
					function showTime(){ 
					if(second==0){
					window.parent.location="${pageContext.request.contextPath}/admin/logout";
					clearInterval(time);
					}
					parent.$.messager.alert("Attention","<font>"+second+"s</font> 后将跳转到登录页面。");
					second--;
					} 
				}else if(d==0){
					parent.$.messager.alert('提示',"请输入正确的原密码");
				}
			}
		});
	}

	function clearForm() {
		$('#ff').form('clear');
	}
</script>
</head>
<body>
	<div class="easyui-panel" title="New Topic" style="width: 99%;">
		<div style="padding: 10px 60px 20px 60px;">
			<form id="ff" method="post">
				<table cellpadding="10" style="margin: 0 auto;">
					<tr>
						<td><label for="name">旧密码:</label></td>
						<td><input class="easyui-passwordbox" 
							name="password"
							data-options="required:true,prompt:'Enter Old password.' " /></td>
					</tr>
					<tr>
						<td><label for="name">新密码:</label></td>
						<td><input class="easyui-passwordbox" 
							name="newPassword"
							data-options="required:true,prompt:'Enter a valid new password.' " /></td>
					</tr>
					<tr>
						<td><label for="name">确认密码:</label></td>
						<td><input class="easyui-passwordbox" 
							name="reNewPassword"
							data-options="required:true,prompt:'Enter a valid confirm new password.' " /></td>
					</tr>
				</table>
			</form>
			<div style="text-align: center; padding: 5px; margin: 5px;">
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="submitForm()" style="margin: 20px 10px; width: 55px;">提&nbsp;&nbsp;交</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="clearForm()" style="margin: 20px 10px; width: 55px;">清&nbsp;&nbsp;空</a>
			</div>
		</div>
	</div>
</body>
</html>