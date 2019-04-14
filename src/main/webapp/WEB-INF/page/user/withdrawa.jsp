<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/js/customer.js"></script>
<body>
	<div class="easyui-panel" title="取款" style="width: 99%;">
		<div style="padding: 10px 60px 20px 60px;">
			<form id="ff" method="post">
				<table cellpadding="10" style="margin: 0 auto;">
					<tr>
					<td><label for="name">当前时间：</label></td>	
					<td><input id="dateNow" readonly="readonly" class="easyui-textbox"  data-options="editorable:false" /></div></td>
					</tr>
					<tr>
						<td><label for="name">金额：</label></td>
						<td><input class="easyui-numberbox" type="text"
							name="balance"
							data-options="required:true,min:0,precision:2,prompt:'请输入金额' " /></td>
					</tr>
					<td><label for="gender">金额来源:</label></td>
					<td><input id="gender" class="easyui-combobox" name="gender"  data-options="editable:false"/>
						</td>
				</table>
				
 
												</select>
				<input type="hidden" name="operation" value="1" />
			</form>
			<div style="text-align: center; padding: 5px; margin: 5px;">
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="submitForm()" style="margin: 20px 10px; width: 55px;">提&nbsp;&nbsp;交</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="clearForm()" style="margin: 20px 10px; width: 55px;">清&nbsp;&nbsp;空</a>
			</div>
</body>
</html>
<script type="text/javascript">
	var i = 0;
	function myDate() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var day = now.getDate();
		var hours = now.getHours();
		var minutes = now.getMinutes();
		var seconds = now.getSeconds();
		var dateNow= year + "年" + month + "月"
		+ day + "日" + hours + ":" + minutes + ":" + seconds;
		$("#dateNow").textbox('setValue',dateNow);
		/* document.getElementById("dateNow").innerHTML = year + "年" + month + "月"
				+ day + "日" + hours + ":" + minutes + ":" + seconds; */
	}
	setInterval(myDate, 1000);
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#gender').combobox({
			valueField :'id',
			panelHeight : 'auto',
			textField : 'text',
			data : [ {
				"id":1,
				"text":"支付宝",
				selected:true
			}, {
				"id":0,
				"text" : "微信"
			} ]
		});

	});
</script>
