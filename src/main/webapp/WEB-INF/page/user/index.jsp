<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
//设置response头信息
//禁止缓存
       	response.setHeader("Buffer","True");
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setHeader("Expires","0");
        response.setHeader("Pragma","no-cache");
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户中心</title>
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
</head>
<body>
<script type="text/javascript">
function showDetail(title,fileName){
	if($('#tabs').tabs('exists', title)) {
		//若已存在则选择该tab
		$('#tabs').tabs('select', title);
	} else {
		//若不存在则新建一个
		$('#tabs').tabs('add', {
			title: title,
			content: '<iframe src="${pageContext.request.contextPath}/html/'+fileName+'" style="width:100%;height:99%" frameborder=0></iframe>',
			closable: true
		});
	}
}
</script>
<script type="text/javascript">
			function addTab(button, page) {
				//判断是不是logout
				if(page!='logout'){
					//获取该标签的text作为tab的title
					var tab_title = $(button).text();
					if($('#tabs').tabs('exists', tab_title)) {
						//若已存在则选择该tab
						$('#tabs').tabs('select', tab_title);
					} else {
						//若不存在则新建一个
						$('#tabs').tabs('add', {
							title: tab_title,
							content: '<iframe src="' + page + '" style="width:100%;height:99%" frameborder=0></iframe>',
							closable: true
						});
					}
				}else{
					parent.window.location.href='${pageContext.request.contextPath}';
				}
			}
		</script>
		<style type="text/css">
			.navbutton {
				background: white;
				margin: 0 5px;
				float: right;
			}
			
			#logo {
				width: 100%;
				height: 75%;
				overflow: hidden;
				background-position: left center;
				background-repeat: no-repeat;
				background-color: rgb(0, 51, 102);
			}
		</style>
	</head>
		<body class="easyui-layout">
			<!-- top布局 -->
			<div data-options="region:'north'" style="height: 200px;">
			<c:choose>
				<c:when test="${sessionScope.user!=null}">
				<div class="easyui-panel" style="padding:5px 15px;">
					<a href="#" class="easyui-splitbutton" data-options="menu:'#mm1',iconCls:'icon-edit'" style="float: right">${sessionScope.user}</a>
				</div>
				<div id="mm1" style="width:150px;">
					<div data-options="iconCls:'icon-undo'"><a href="javascript:void(0)" class="easyui-linkbutton navbutton" data-options="plain:true" onclick="updatePassword()"><b>修改密码&nbsp;</b></a></div>
					<div class="menu-sep"></div>
					<div data-options="iconCls:'icon-undo'"><a href="logout" class="easyui-linkbutton navbutton" data-options="plain:true"><b>退出账号&nbsp;</b></a></div>
				</div>
				</c:when>
				<c:otherwise>
					<a href="logout" class="easyui-linkbutton navbutton"
						data-options="plain:true"><b>退出账号&nbsp;</b></a>
				</c:otherwise>
			</c:choose>
				<div id="logo" style="background-image: url(../images/logo.png)">
				</div>
			</div>
			<!-- left布局 -->
			<div data-options="region:'west',title:'导航菜单',iconCls:'icon-reload'" style="width: 300px;">
				<div id="aa" class="easyui-accordion" data-options="fit:'true'" style="width: 300px; height: 200px;">
					<div title="用户管理" data-options="selected:true" style="overflow: auto; padding: 10px;">
						<ul id="tt" class="easyui-tree">
							<li>
								<span>账户信息</span>
								<ul>
									<li>
										<span><b onclick="addTab(this,'lookDealRecord');" >查看交易记录</b></span>
									</li>
									
								</ul>
							</li>
							<li>
								<span>资产管理</span>
								<ul>
									<li>
										<span><b onclick="addTab(this,'deposit');" >存&nbsp;&nbsp;款</b></span>
									</li>
									<li>
										<span><b onclick="addTab(this,'withdrawa');" >取&nbsp;&nbsp;款</b></span>
									</li>
									<!-- <li>
										<span><b onclick="addTab(this,'transfer');" >转&nbsp;&nbsp;账</b></span>
									</li> -->
								</ul>
							</li>
							<li>
								<span>个人中心</span>
								<ul>
									
									<li>
										<span><b onclick="addTab(this,'updatePassword');" >修改密码</b></span>
									</li>
									<li>
										<span><b onclick="addTab(this,'logout');" >退出账号</b></span>
									</li>
								</ul>
							</li>
						</ul>
					</div>
					<div title="财经新闻">
						<iframe src="userNewsList" style="width:100%;height:99%" frameborder=0></iframe>
					</div>
					<div title="正在努力开发中……">正在努力开发中</div>
				</div>
			</div>
			<div data-options="region:'center',title:'内容'" style="padding: 5px; background: #eee;">
				<!-- 此处是面板容器 -->
				<div id="tabs" class="easyui-tabs" data-options="fit:'true'">
				</div>
			</div>
			<div data-options="region:'south'" style="width: auto;height: 50px;">
				<p align="center">
				&copy;&nbsp;&nbsp;&nbsp;2015-2019 Betty Shi.com 版权所有ICP证: 东师人文-20190515
			</p>
			</div>
			<!-- 添加用户界面 -->
			<div class="easyui-window" id="addWindow"
		data-options="title:'管理员登录',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,closable:true,draggable:false,resizable:false,iconCls:'icon-lock'"
		style="width: 350px; padding: 20px 50px 20px 50px;">
		<form id="addAdminForm" method="post">
			<div style="margin-bottom: 5px">
				<input id="loginame" type="text" name="loginame"
					data-options="iconCls:'icon-man',prompt:'账号',required:true"
					class="easyui-textbox"
					style="width: 100%; height: 30px; padding: 12px">
			</div>
			<div style="margin-bottom: 5px">
				<input id="name" type="text" name="name"
					data-options="iconCls:'icon-man',prompt:'真实姓名',required:true"
					class="easyui-textbox"
					style="width: 100%; height: 30px; padding: 12px">
			</div>
			<div style="margin-bottom: 5px">
				<input id="password"  name="password"
					data-options="prompt:'密码',required:true"
					class="easyui-passwordbox"
					style="width: 100%; height: 30px; padding: 12px">
			</div>
			<div style="margin-bottom: 5px">
				<input id="repassword"  name="repassword"
					data-options="prompt:'确认密码',required:true"
					class="easyui-passwordbox"
					style="width: 100%; height: 30px; padding: 12px">
			</div>
			<a class="easyui-linkbutton" href="javascript:void(0)" style="padding: 5px 0px; width: 100%;"
				onclick="addAdmin()"> <span style="font-size: 14px;">提交</span>
			</a>
		</form>
	</div>
		</body>
</html>
<script type="text/javascript">
function addAdmin(){
	$('#addAdminForm').form('submit',{
		url : '${pageContext.request.contextPath}/admin/addAdmin',
		onSubmit: function(){
			var isValid = $(this).form('validate');
			var loginame=$("#loginame").val();    
	        var p1=$("#password").val();    
	        var p2=$("#repassword").val();  
	        if(p1==p2){
	        	return true;
	        }else if(loginame=="admin"){
	        	parent.$.messager.alert("Attention","不能注册admin为账号");
	        	return false;
	        }else if(p1!=p2){
	        	parent.$.messager.alert("Attention","两次密码不一致");
	        	return false;
	        }else if(isValid){
	        	parent.$.messager.alert("Attention","请输入正确的账号和密码");
	        	return false;
	        }
	    },
		success : function(d) {
			if(d==1){
				var time=setInterval (showTime, 1000);
				var second=3;
				function showTime()
				{ 
				if(second==0)
				{
				window.location="${pageContext.request.contextPath}/admin/index";
				clearInterval(time);
				}
				parent.$.messager.alert("Attention","<font>"+second+"s</font> 后将跳转到主页。");
				second--;
				}
			}else if (d==0){
				parent.$.messager.alert("Attention","该用户名已存在");
			}
			}
		});
	}
	function cutCreateAccount () {
		if($('#tabs').tabs('exists', '开&nbsp;&nbsp;&nbsp;户')) {
					//若已存在则选择该tab
					$('#tabs').tabs('select', '开&nbsp;&nbsp;&nbsp;户');
				} else {
					//若不存在则新建一个
					$('#tabs').tabs('add', {
						title: '开&nbsp;&nbsp;&nbsp;户',
						content: '<iframe src="createAccount" style="width:100%;height:99%" frameborder=0></iframe>',
						closable: true
					});
				}
	}
	function updatePassword() {
		if($('#tabs').tabs('exists', '修改密码')) {
					//若已存在则选择该tab
					$('#tabs').tabs('select', '修改密码');
				} else {
					//若不存在则新建一个
					$('#tabs').tabs('add', {
						title: '修改密码',
						content: '<iframe src="updatePassword" style="width:100%;height:99%" frameborder=0></iframe>',
						closable: true
					});
				}
	}

</script>