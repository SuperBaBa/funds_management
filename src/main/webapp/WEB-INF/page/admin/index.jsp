<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	//设置response头信息
	//禁止缓存
	response.setHeader("Buffer", "True");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Expires", "0");
	response.setHeader("Pragma", "no-cache");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理</title>
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
</head>
<body>
	<script type="text/javascript">
		function addTab(button, page) {
			//判断是不是logout
			if(page!='logout'){
				//获取该标签的text作为tab的title
				var tab_title = $(button).text();
				if ($('#tabs').tabs('exists', tab_title)) {
					//若已存在则选择该tab
					$('#tabs').tabs('select', tab_title);
				} else {
					//若不存在则新建一个
					$('#tabs')
							.tabs(
									'add',
									{
										title : tab_title,
										content : '<iframe src="'
												+ page
												+ '" style="width:100%;height:99%" frameborder=0></iframe>',
										closable : true
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
			<c:when	test="${sessionScope.admin!=null}">
				<div class="easyui-panel" style="padding: 5px 15px;">
					<a href="#" class="easyui-splitbutton"
						data-options="menu:'#mm1',iconCls:'icon-edit'" style="float: right">${sessionScope.admin}</a>
				</div>
				<div id="mm1" style="width: 150px;">
				<c:choose>
				<c:when	test="${sessionScope.admin=='admin'}">
					<div data-options="iconCls:'icon-redo'">
						<a href="javascript:void(0)"
							onclick="$('#addWindow').window('open')"
							class="easyui-linkbutton navbutton" data-options="plain:true"><b>添加管理员</b></a>
					</div>
					<div class="menu-sep"></div>
				</c:when>
				</c:choose>
					<div data-options="iconCls:'icon-undo'">
						<a href="logout" class="easyui-linkbutton navbutton"
							data-options="plain:true"><b>退出账号&nbsp;</b></a>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div data-options="iconCls:'icon-undo'">
					<a href="logout" class="easyui-linkbutton navbutton"
						data-options="plain:true"><b>退出账号&nbsp;</b></a>
				</div>
			</c:otherwise>
		</c:choose>
		<div id="logo" style="background-image: url(../images/logo.png)">
		</div>
	</div>
	<!-- left布局 -->
	<div data-options="region:'west',title:'导航菜单',iconCls:'icon-reload'"
		style="width: 300px;">
		<div id="aa" class="easyui-accordion" data-options="fit:'true'"
			style="width: 300px; height: 200px;">
			<div title="用户管理" data-options="selected:true"
				style="overflow: auto; padding: 10px;">
				<ul id="tt" class="easyui-tree">
					<li><span>账户编辑</span>
						<ul>
							<li><span><b
									onclick="addTab(this,'accountOfAllList');">所有账户</b></span></li>
							<li><span><b
									onclick="addTab(this,'accountOfFrozenList');">已冻结账户</b></span></li>
							<li><span><b
									onclick="addTab(this,'accountOfOpenList');">已开启账户</b></span></li>
							<li><span><b onclick="addTab(this,'createAccount');">开&nbsp;&nbsp;&nbsp;户</b></span>
							</li>
						</ul></li>
					<li><span>新闻管理</span>
						<ul>
							<li><span><b onclick="addTab(this,'newsList');">新闻列表</b></span>
							</li>
							<li><span><b onclick="addTab(this,'newsCreate');">添加新闻</b></span>
							</li>
						</ul></li>
					<li><span>个人中心</span>
						<ul>
							<li><span><b onclick="addTab(this,'updatePassword');">修改密码</b></span>
							</li>
							<li><span><b onclick="addTab(this,'logout');">退出账号</b></span>
							</li>
						</ul></li>
				</ul>
			</div>
			<div title="正在努力开发中……">正在努力开发中</div>
			<div title="正在努力开发中……">正在努力开发中</div>
		</div>
	</div>
	<div data-options="region:'center',title:'内容'"
		style="padding: 5px; background: #eee;">
		<!-- 此处是面板容器 -->
		<div id="tabs" class="easyui-tabs" data-options="fit:'true'"></div>
	</div>
	<!-- footer布局 -->
	<div data-options="region:'south'" style="width: auto; height: 50px;">
		<p align="center">&copy;&nbsp;&nbsp;&nbsp;2015-2019 Betty Shi.com 版权所有ICP证: 东师人文-20190515</p>
	</div>
	<!-- 添加用户界面 -->
	<div class="easyui-window" id="addWindow"
		data-options="title:'添加管理员',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,closable:true,draggable:false,resizable:false,iconCls:'icon-lock'"
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
				<input id="password" name="password"
					data-options="prompt:'密码',required:true" class="easyui-passwordbox"
					style="width: 100%; height: 30px; padding: 12px">
			</div>
			<div style="margin-bottom: 5px">
				<input id="repassword" name="repassword"
					data-options="prompt:'确认密码',required:true"
					class="easyui-passwordbox"
					style="width: 100%; height: 30px; padding: 12px">
			</div>
			<a class="easyui-linkbutton" href="javascript:void(0)"
				style="padding: 5px 0px; width: 100%;" onclick="addAdmin()"> <span
				style="font-size: 14px;">提交</span>
			</a>
		</form>
		<input type="hidden" id="json-title" >
		<input type="hidden" id="json-newsAbstract" >
		<input type="hidden" id="json-html" >
	</div>
</body>
</html>
<script type="text/javascript">
	function addAdmin() {
		$('#addAdminForm').form('submit',
						{
							url : '${pageContext.request.contextPath}/admin/addAdmin',
							onSubmit : function() {
								var isValid = $(this).form('validate');
								var loginame = $("#loginame").val();
								var p1 = $("#password").val();
								var p2 = $("#repassword").val();
								if (p1 == p2) {
									return true;
								} else if (loginame == "admin") {
									parent.$.messager.alert("Attention",
											"不能注册admin为账号");
									return false;
								} else if (p1 != p2) {
									parent.$.messager.alert("Attention",
											"两次密码不一致");
									return false;
								} else if (isValid) {
									parent.$.messager.alert("Attention",
											"请输入正确的账号和密码");
									return false;
								}
							},
							success : function(d) {
								if (d == 1) {
									//	window.location.href = '${pageContext.request.contextPath}/admin/index';
									var time = setInterval(showTime, 1000);
									var second = 3;
									function showTime() {
										if (second == 0) {
											window.location = "${pageContext.request.contextPath}/admin/index";
											clearInterval(time);
										}
										parent.$.messager.alert("Attention",
												"<font>" + second
														+ "s</font> 后将跳转到主页。");
										second--;
									}
								} else if (d == 0) {
									parent.$.messager.alert("Attention",
											"该用户名已存在");
								}
							}
						});
	}
	function cutCreateAccount() {
		if ($('#tabs').tabs('exists', '开&nbsp;&nbsp;&nbsp;户')) {
			//若已存在则选择该tab
			$('#tabs').tabs('select', '开&nbsp;&nbsp;&nbsp;户');
		} else {
			//若不存在则新建一个
			$('#tabs')
					.tabs(
							'add',
							{
								title : '开&nbsp;&nbsp;&nbsp;户',
								content : '<iframe src="createAccount" style="width:100%;height:99%" frameborder=0></iframe>',
								closable : true
							});
		}
	}
	function cutCreateNews() {
		if ($('#tabs').tabs('exists', '添加新闻')) {
			//若已存在则选择该tab
			$('#tabs').tabs('select', '添加新闻');
		} else {
			//若不存在则新建一个
			$('#tabs')
					.tabs(
							'add',
							{
								title : '添加新闻',
								content : '<iframe src="newsCreate" style="width:100%;height:99%" frameborder=0></iframe>',
								closable : true
							});
		}
	}
	function updateNews(id,title,newsAbstract,context){
		$.ajax({
			url:'${pageContext.request.contextPath}/admin/news/upateNews',
			dataType:'json',
			type:'post',
			data:{
				id:id,
				title:title,
				newsAbstract:newsAbstract,
				context:context,
			},
			success:function (data){
				if ($('#tabs').tabs('exists', data.title)) {
					//若已存在则选择该tab
					$('#tabs').tabs('select', data.title);
				} else {
					//若不存在则新建一个
					$('#tabs').tabs('add',
									{
										title : data.title,
										content : '<iframe src="newsCreate" id="ifm" name="updateNews"  onload="onLoaded();" style="width:100%;height:99%" frameborder=0></iframe>',
										closable : true
									});
				}
				$('#json-title').val(data.title);
				$('#json-newsAbstract').val(data.newsAbstract);
				$('#json-html').val(data.html);
			}
		});
	}
	//调用子页面loading方法获取父页面中的隐藏域的值，初始化页面
	function onLoaded(){
		//$("#ifm").contents().find("#content").innerHTML=html;
		document.getElementById("ifm").contentWindow.loading();
	}
	function slideMsg(type,num){
		$.messager.show({
			title : '我的消息',
			msg : '已'+type+num+'条数据',
			timeout : 2000,
			showType : 'slide'
		});
	}
</script>