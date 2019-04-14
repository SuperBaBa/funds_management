<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
<!--搜索框所在的布局-->
<div id="search_container" data-options="region:'north'"
	style="height: 50px;">
	<div style="display: inline; left: 32%; position: absolute; top: 2%; padding: 5px;">
		<label style="font-size: 12px; font-weight: bold; color: #777;">站内搜索</label>&nbsp;&nbsp;&nbsp;
		<input id="keyWords" class="easyui-searchbox" style="width: 350px;" data-options="prompt:'输入 新闻标题 '" />
	</div>
</div>
<!-- 列表展示 -->
<div id="datagrid_container" data-options="region:'south'" style="height: 100%;">
	<table id="dg" class="easyui-datagrid" title="新闻管理"
		style="width: 100%; height: auto"
		data-options="
				iconCls: 'icon-edit',
				toolbar: '#tb',
				 rownumbers : true,  
				 pageList: [10,15,20,30],
				 loadMsg : '正在加载中......',  
				method: 'post',
				pagination:true,
				fit:true,
				fitColumns:true,
				checkOnSelect:false
			">
	</table>
 </div> 
	<div id="tb" style="height: auto">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">添加新闻</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除新闻</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">查询新闻</a>
	</div>
<script type="text/javascript">
		//添加新闻
		function append() {
			top.cutCreateNews()
		}
		//删除新闻
		function removeit() {
			var idArray = new Array();
			$(".datagrid-row input[name='id']:checked").each(function() {
				idArray.push($(this).val());
			});

			parent.$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
				if (r) {
					$.ajax({
						url : "news/deleteById",
						type : "post",
						dataType : "json",
						data : {
							"idArray" : idArray
						},
						success : function(msg) {
							window.location.reload();
							top.deleteMsg();
						},
						error : function() {
						}
					});
				}
			});
		}

		function accept() {
			parent.$.messager.confirm('确认', '您确认想要保存记录吗？', function(r) {
				if (r) {
					$.messager.show({
						title : '我的消息',
						msg : '消息将在2秒后关闭。',
						timeout : 2000,
						showType : 'slide'
					});

				}
			});
		}
		//撤销操作
		function reject() {
			parent.$.messager.confirm('确认', '您确认想要撤销记录吗？', function(r) {
				if (r) {
					$.messager.show({
						title : '我的消息',
						msg : '消息将在2秒后关闭。',
						timeout : 2000,
						showType : 'slide'
					});

				}
			});
		}
		//查询新闻
		function getChanges() {
			$('#search_container').toggle(function() {
			});
		}
		//查询传参
		function search(value){
			var name=/[\u4e00-\u9fa5]/
				if(name.test(value)){
					$('#keyWords').attr("name","title");
					$('#dg').datagrid('load',{
						title:value,
						search:1
					})
				}else{
					parent.$.messager.alert('Attention','新闻标题要好好输哟~');
				}
		}
		//回车进行搜索
		$(function(){ 
			$('#keyWords').searchbox({
				searcher : function (value) {
					search(value);
				}
			 });
		}); 
	</script>
<script type="text/javascript">
	$(document).ready(function() {
						$("#search_container").hide();
						$('#w').window('close');
						$('#dg').datagrid({
											url : 'news/queryAllList',
											onClickRow : function(index, row) {
												var id = row["id"];
												var title = row["title"];
												var newsAbstract = row["newsAbstract"];
												var context = row["context"];
												top.updateNews(id,title,newsAbstract,context);
											},
											columns : [ [
													{
														field : 'id',
														align : 'center',
														resizable : true,
														checkbox : true
													},
													{
														field : 'title',
														title : '新闻标题',
														align : 'center',
														width : 20,
														formatter : function(
																value, row,
																index) {
															return "<a href='javascript:void(0)' style='text-decoration:none;color:black' class='easyui-linkbutton'>"
																	+ value
																	+ "</a>";
														}
													},
													{
														field : 'lastUpdateTime',
														title : '最后一次修改时间',
														align : 'center',
														width : 20,
														sortable:true
													}, {
														field : 'newsAbstract',
														title : '新闻摘要',
														align : 'center',
														width : 100
													}, ] ],
										});
					});
</script>
