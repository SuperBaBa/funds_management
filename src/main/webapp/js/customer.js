/*
	 * 1存款2取款3转账 接收到的user除了id或者balance以外全是交易对象的信息,user只是负责传递数据 11存款成功
	 * 10存款失败（比如数据库链接断了） 21取款成功 20余额不足 31转账成功 30转账失败 301转账对象信息不匹配 302余额不足 303为完成事务
	 */
function submitForm() {
		$('#ff').form('submit', {
			 url:'fundsOperation',    
			   onSubmit: function(){  
			    	var isValid = $(this).form('validate');
			    	if (isValid) {
			    		return true;
			    	}else{
			    		parent.$.messager.alert('警告', '请正确填写数据');
			    		return false;
			    	}
			    },    
			    success:function(data){ 
			    	if(data==11){
			    		/*var time=setInterval (showTime, 1000);
						var second=1;*/
						parent.$.messager.alert("SUCCESS","存款成功<font></font> 后将刷新页面。");
						window.location.reload();
						/*function showTime(){ 
							if(second==0){
							window.location.reload();
							clearInterval(time);
							}
						second--;
						}*/
			    	}else if(data==10){
						parent.$.messager.alert("存款失败","系统错误，请联系管理员。");
			    	}else if(data==21){
			    		parent.$.messager.alert("SUCCESS","取款成功<font></font> 后将刷新页面。");
			    		window.location.reload();
			    		/*var time=setInterval (showTime, 1000);
						var second=2;
						function showTime(){ 
							if(second==0){
								window.location.reload();
							clearInterval(time);
							}
						second--;
						}*/
			    	}else if(data==20){
						parent.$.messager.alert("取款失败","余额不足，请保证账户资金充足。");
			    	}else if(data==31){
			    		parent.$.messager.alert("SUCCESS","转账成功<font></font> 后将刷新页面。");
			    		window.location.reload();
			    		/*var time=setInterval (showTime, 1000);
						var second=2;
						parent.$.messager.alert("SUCCESS","转账成功<font>"+second+"s</font> 后将刷新页面。");
						function showTime(){ 
							if(second==0){
								window.location.reload();
							clearInterval(time);
							}
						second--;
						}*/
			    	}else if(data==30){
						parent.$.messager.alert("转账失败","系统错误，请联系管理员。");
			    	}else if(data==301){
						parent.$.messager.alert("转账失败","转账对象信息不匹配");
			    	}else if(data==302){
						parent.$.messager.alert("转账失败","余额不足，请保证账户资金充足。");
			    	}else if(data==303){
						parent.$.messager.alert("转账失败","系统错误，请联系管理员。");
			    	}else{
						parent.$.messager.alert("警告","请勿重复提交");
			    	}
			    }    

		});
	}

	function clearForm() {
		$('#ff').form('clear');
	}