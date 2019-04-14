<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../system/easyuiAsset.jsp"></jsp:include>
<!-- wangEditor -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/wangEditor/wangEditor.min.js"></script>
	<style type="text/css">
	.input-container{
	margin: 10px;
	padding: 5px;
	}
	</style>
</head>
<body>
	<div style="padding: 10px;">
		<form id="ff" method="post">
		<div class="input-container">
			<label for="title">新闻标题:</label> <input class="easyui-textbox"
				name="title" data-options="required:true,width:'60%',height:'35px',iconCls:'icon-edit'" id="title" />
			</div>
			<div class="input-container">
			<label for="title">新闻摘要:</label> 
			<input class="easyui-textbox" name="newsAbstract"
				data-options="required:true,width:'90%',height:'35px',iconCls:'icon-edit'"  id="newsAbstract"
				 />
			</div>
			<div class="input-container">
				<div id="content">
					<p id='cc'>此处输入新闻</p>
				</div>
				<input name="context" id="s-editor" type="hidden" />
			</div>
		</form>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm()" style="margin: 20px 10px; width: 55px;">提&nbsp;&nbsp;交</a>

	</div>


	<script type="text/javascript">
		var E = window.wangEditor
		var editor = new E('#content')

		// 下面两个配置，使用其中一个即可显示“上传图片”的tab。但是两者不要同时使用！！！
		// editor.customConfig.uploadImgShowBase64 = true   // 使用 base64 保存图片
		editor.customConfig.uploadImgServer = '${pageContext.request.contextPath}/editor/upload';// 上传图片到服务器
		editor.customConfig.uploadFileName = 'myFileName';
		// 自定义菜单配置
		editor.customConfig.menus = [ 
		'head', // 标题
		'bold', // 粗体
		'fontSize', // 字号
		'fontName', // 字体
		'italic', // 斜体
		'underline', // 下划线
		'strikeThrough', // 删除线
		'foreColor', // 文字颜色
		'backColor', // 背景颜色
		'link', // 插入链接
		'list', // 列表
		'justify', // 对齐方式
		'quote', // 引用
		'emoticon', // 表情
		'image', // 插入图片
		'table', // 表格
		'video', // 插入视频
		'code', // 插入代码
		'undo', // 撤销
		'redo' // 重复
		];
		editor.customConfig.debug = true;
		editor.customConfig.uploadImgHooks = {
			success : function(xhr, editor, result) {
				// 图片上传并返回结果，图片插入成功之后触发
				// xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，result 是服务器端返回的结果
				console.log(result);
			}
		};
		editor.create();
	</script>
</body>
</html>
<script type="text/javascript">
	//提交新闻属性给后台
	function submitForm() {
		var content = editor.txt.html();
		$('#s-editor').val(content);
		$('#ff').form('submit', {
			url : "news/newsCreate",
			onSubmit : function() {
				var isValid = $(this).form('validate');
				if (isValid) {
					return true;
				}else{
					return false;
				}
			},
			success : function(data) {
				parent.$.messager.alert("Attention", data);
				window.location.reload();
			}
		});
	}
	function loading() {
		var title = parent.$("#json-title").val();
		var newsAbstract = parent.$("#json-newsAbstract").val();
		var html = parent.$("#json-html").val();
		$('#title').textbox('setValue', title);
		$('#newsAbstract').textbox('setValue', newsAbstract);
		editor.txt.html(html);
	}
</script>