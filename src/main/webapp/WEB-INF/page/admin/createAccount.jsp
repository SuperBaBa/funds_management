<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
<script type="text/javascript">
	function submitForm() {
		$('#ff').form('submit', {
			 url:'${pageContext.request.contextPath}/admin/createNewAccount',    
			   onSubmit: function(){  
			    	var isValid = $(this).form('validate');
			    	if ($("input[name='password']").val()!=$("input[name='repassword']").val()) {
			    		parent.$.messager.alert('警告', '两次密码不匹配');
			    		return false;
			    	}else if(isValid){
			    		return true;
			    	}else{
			    		parent.$.messager.alert('警告', '请正确填写数据');
			    		return false;
			    	}
			    },    
			    success:function(data){ 
			    	if(data==1){
			    		alert("开户成功")
			    		window.location.reload(); 
			    	}
			    	else{
			    		window.location.reload(); 
			    	}
			    }    

		});
	}

	function clearForm() {
		$('#ff').form('clear');
	}
</script>
<!--
    	作者：jiacongqian@126.com
    	时间：2018-07-30
    	描述：验证手机号的正则表达式
    -->
<script type="text/javascript">
	$.extend($.fn.validatebox.defaults.rules,{
		   			phoneNum : { //验证手机号   
							validator : function(value, param) {
								return /^1[3-8]+\d{9}$/.test(value);
							},	
							message : '请输入正确的手机号码。'
					},
					telNum : { //既验证手机号，又验证座机号
					validator : function(value, param) {
								return /(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\d3)|(\d{3}\-))?(1[358]\d{9})$)/.test(value);
							},
							message : '请输入正确的电话号码。'
						}
					});
</script>
</head>
<body>
<body style="width: 99%">
	<div class="easyui-panel" title="New Topic" style="width: 99%;">
		<div style="padding: 10px 60px 20px 60px;">
			<form id="ff" method="post" data-options="novalidate:true">
				<table cellpadding="10" style="margin: 0 auto;">
					<tr>
						<td><label for="password">密码:</label></td>
						<td><input class="easyui-passwordbox " 
							name="password"
							data-options="required:true,prompt:'Enter a valid confirm password.' " /></td>
						<td><label for="name">姓名:</label></td>
						<td><input class="easyui-textbox" name="name" 
							data-options="required:true,prompt:'Enter a real name.'" /></td>
					</tr>
					<tr>
						<td><label for="repassword">确认密码:</label></td>
						<td><input class="easyui-passwordbox" 
							name="repassword" 
							data-options="required:true,prompt:'Enter a valid confirm password.' " /></td>
						<td><label for="gender">性别:</label></td>
						<td><input id="gender" class="easyui-combobox" name="gender"  data-options="editable:false"/>
						</td>
					</tr>
					<tr>
						<td><label for="balance">开户金额:</label></td>
						<td><input class="easyui-numberbox" type="text"
							name="balance"
							data-options="required:true,min:0,precision:2,prompt:'Enter a valid Initial investments.' " /></td>
						<td><label for="birthday">出生日期:</label></td>
						<td><input class="easyui-datebox" 
							name="birthday" required="required" editable="false"
							data-options="required:true,prompt:'Enter a valid date of birth.'" /></td>
					</tr>
					<tr>
						<td><label for="address">家庭住址 :</label></td>
						<td><input class="easyui-textbox" type="text" name="address"
							data-options="required:true,prompt:'Enter real Street Address.'" /></td>

						<td><label for="idNumber">身份证号:</label></td>
						<td><input class="easyui-textbox" type="text "
							name="idNumber"
							data-options="required:true,prompt:'Enter real ID number.',validType:'idcared'" /></td>
					</tr>
					<tr>
						<td><label for="phoneNumber">手机号码:</label></td>
						<td><input class="easyui-textbox " type="text "
							name="phoneNumber"
							data-options="required:true ,validType:'phoneNum',prompt:'Enter a valid phone number.'" /></td>
						<td><label for="email">Email:</label></td>
						<td><input class="easyui-textbox " type="text " name="email"
							data-options="required:true,validType:'email',prompt:'Enter a valid email.'" /></td>
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
<script type="text/javascript">
	$(document).ready(function() {
		$('#gender').combobox({
			valueField :'id',
			panelHeight : 'auto',
			textField : 'text',
			data : [ {
				"id":1,
				"text":"男",
				selected:true
			}, {
				"id":0,
				"text" : "女"
			} ]
		});

	});
</script>
<script type="text/javascript">
	//身份证号的验证
	var aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"}
	function isCardID(sId) {
		if (!/^\d{17}(\d|x)$/i.test(sId))
			return "你输入的身份证长度或格式错误";
		sId = sId.replace(/x$/i, "a");
		if (aCity[parseInt(sId.substr(0, 2))] == null)
			return "你的身份证地区非法";
		return true;
	}

	$.extend($.fn.validatebox.defaults.rules, {
		idcared : {
			validator : function(value, param) {
				var flag = isCardID(value);
				return flag == true ? true : false;
			},
			message : '不是有效的身份证号码'
		}
	});
</script>