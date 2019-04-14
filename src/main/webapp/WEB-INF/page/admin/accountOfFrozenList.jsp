<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
	
<div id="search_container" data-options="region:'north'"
	style="height: 50px;">
	<div style="display: inline; left: 32%; position: absolute; top: 2%; padding: 5px;">
		<label style="font-size: 12px; font-weight: bold; color: #777;">站内搜索</label>&nbsp;&nbsp;&nbsp;
		<input id="keyWords" class="easyui-searchbox" style="width: 350px;" data-options="prompt:'输入 姓名 /电话号 '" />
	</div>
</div>
<div data-options="region:'south'" style="height: 100%;">
	<table id="dg"
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
			"
		title="已冻结账户"></table>
	<div id="tb" style="height: auto">
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销</a> -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok',plain:true" onclick="using()">启用</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-cancel',plain:true" onclick="freeze()">冻结</a> -->
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-search',plain:true"
			onclick="getChanges()">搜索</a>
	</div>
</div>
<div id="window" class="easyui-window" title="详细信息"
	data-options="iconCls:'icon-save',resizable:true"
	style="width: 500px; height: auto; padding: 10px;">
	<table id="pg" style="width:auto"></table>
</div>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						//隐藏搜索框区域
						$("#search_container").hide();
						$('#window').window('close');
						//数据表的字段
						$('#dg')
								.datagrid(
										{
											url : 'queryAllList',
											queryParams : {
												status : '0'
											},
											onClickRow : function(index, row) {
												var id = row["id"];
												$('#window').window('open');
												$('#pg').propertygrid({
													inline:true,
													url : "getInfoById",
													width : 'auto',
													height : 'auto',
													showGroup : false,
													scrollbarSize : 0,
													queryParams : {
														id : id
													},
													columns : [ [ {
														field : 'name',
														title : 'Name',
														width : 100,
														resizable : true
													}, {
														field : 'value',
														title : 'Value',
														width : 100,
														resizable : false
													} ] ]
												});
											},
											columns : [ [
													{
														field : 'id',
														align : 'center',
														resizable : true,
														checkbox : true
													},
													{
														field : 'accountNumber',
														title : '账户',
														align : 'center',
														width : 50,
														formatter : function(
																value, row,
																index) {
															return "<a href='javascript:void(0)'style='text-decoration:none; color:black' class='easyui-linkbutton' onclick=''>"
																	+ value
																	+ "</a>";
														}
													}, {
														field : 'balance',
														title : '账户余额',
														align : 'right',
														width : 20,
														sortable:true
													}, {
														field : 'name',
														title : '姓名',
														align : 'center',
														width : 20
													}, {
														field : 'address',
														title : '详细地址',
														align : 'center',
														width : 80
													}, {
														field : 'idNumber',
														title : '身份证号',
														align : 'center',
														width : 80
													}, {
														field : 'phoneNumber',
														title : '电话号码',
														align : 'center',
														width : 50
													}, {
														field : 'status',
														title : '状态',
														align : 'center',
														width : 20,
														formatter: function(value,row,index){
															if(value==1){
																return value='启用中';
															}else if(value==0){
																return value='已冻结';
															}
														}
														} 
													] ]
										});
					});
</script>
