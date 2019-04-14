<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
</head>
<body>
<!--搜索框所在的布局-->
		<div id="search_container" data-options="region:'north'" style="height:50px;">
			<div style="display:inline;left: 32%;position:absolute;top: 2%;padding:5px;">
				<label style="font-size: 12px; font-weight: bold;color: #777;">站内搜索</label>&nbsp;&nbsp;&nbsp;
				<input id="ss" class="easyui-searchbox" style="width:350px;" data-options="prompt:'Search the key words.'" />
			</div>
		</div>
		<div id="datagrid_container" data-options="region:'south'" style="height: 100%;">

			<table id="dg" class="easyui-datagrid" title="所有账户" style="width:100%;height:auto" data-options="
				 rownumbers : true,  
				 pageList: [10,15,20,30],
				 loadMsg : '官人别急嘛......',  
				method: 'post',
				fitColumns:true,
				checkOnSelect:false,
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				url: '',
				pagination:true,
				fit:true
			">
			</table>

			<div id="tb" style="height:auto">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">搜索</a>
			</div>
		</div>
</body>
</html>
<script type="text/javascript">
	$(document).ready(function() {
		$("#search_container").hide();
		$('#dg').datagrid({
			url: 'showDealRecord',
			columns: [
				[{
						field: 'tradingObject',
						title: '交易对象',
						align: 'center',
						width: 80
					},
					{
						field: 'transactionFunds',
						title: '交易金额',
						align: 'center',
						width: 80
					},
					{
						field: 'dealType',
						title: '交易类型',
						align: 'center',
						width: 80,
						formatter: function(value,row,index){
								if (row.dealType){
									return row.dealType.type;
								} else {
									return value;
								}
						}
					},
					{
						field: 'transactionDate',
						title: '交易日期',
						align: 'center',
						width: 80
					}
				]
			]
		});
	});
</script>
<script type="text/javascript">
	function getChanges() {
		$('#search_container').toggle(function() {

		});
	}
</script>