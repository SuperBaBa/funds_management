/*
 * 调用父页面的新增账户选项卡
 */
function append() {
	top.cutCreateAccount();
}
/*
 * 删除数据，并调用父页面显示slide信息
 */
function removeit() {
	var idArray = new Array();
	$(".datagrid-row input[name='id']:checked").each(function() {
		idArray.push($(this).val());
	});

	parent.$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
		if (r) {
			$.ajax({
				url : "deleteById",
				type : "post",
				dataType : "json",
				data : {
					"idArray" : idArray
				},
				success : function(msg) {
					window.location.reload();
					top.slideMsg('删除', idArray.length);
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

function using() {
	var idArray = new Array();
	var statusArray = new Array();
	$(".datagrid-row input[name='id']:checked").each(function() {
		idArray.push($(this).val());
	});
	parent.$.messager.confirm('确认', '您确认想要启用吗？', function(r) {
		if (r) {
			$.ajax({
				url : "usingById",
				type : "post",
				dataType : "json",
				data : {
					"idArray" : idArray
				},
				success : function(msg) {
					window.location.reload();
					top.slideMsg('启用', idArray.length);
				},
				error : function() {
				}
			});

		}
	});

}

function freeze() {
	var idArray = new Array();
	$(".datagrid-row input[name='id']:checked").each(function() {
		idArray.push($(this).val());
	});
	parent.$.messager.confirm('确认', '您确认想要冻结吗？', function(r) {
		if (r) {
			$.ajax({
				url : "freezeById",
				type : "post",
				dataType : "json",
				data : {
					"idArray" : idArray
				},
				success : function(msg) {
					window.location.reload();
					top.slideMsg('冻结', idArray.length);
				},
				error : function() {
				}
			});

		}
	});

}

function getChanges() {
	$('#search_container').toggle(function() {
	});
}
// 查询传参
function search(value) {
	var name = /[\u4e00-\u9fa5]/
	if (name.test(value)) {
		$('#keyWords').attr("name", "name");
		$('#dg').datagrid('load', {
			name : value,
			search : 1
		})
	} else {
		$('#keyWords').attr("name", "phoneNumber");
		$('#dg').datagrid('load', {
			phoneNumber : value,
			search : 1
		})
	}
}
// 回车进行搜索
$(function() {
	$('#keyWords').searchbox({
		searcher : function(value) {
			search(value);
		}
	});
});