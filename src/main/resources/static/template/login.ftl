<!DOCTYPE html>
<html>
<#assign contextPath="${request.contextPath}"/>
<head>
<meta charset="utf-8" />
<title>接口测试平台</title>
<link rel="stylesheet" type="text/css" href="${contextPath}/css/style.css" />
<style>
body {
	height: 100%;
	background: #16a085;
	overflow: hidden;
}

canvas {
	z-index: -1;
	position: absolute;
}
.tips{ font-size:12px; height:30px; clear:both;color:red}
.tips_dd_init{
	display:none;
}
</style>
<script src="${contextPath}/js/jquery-1.11.3.js"></script>
<script src="${contextPath}/js/Particleground.js"></script>
<script type="text/javascript" src="${contextPath}/js/jquery.md5.js" charset="UTF-8"></script>
<script type="text/javascript" src="${contextPath}/js/common.js" charset="UTF-8"></script>
<script type="text/javascript" src="${contextPath}/js/jquery.cookie.js" charset="UTF-8"></script>
<script>
	$(function() {
		//粒子背景特效
		$('body').particleground({
			dotColor : '#5cbdaa',
			lineColor : '#5cbdaa'
		});
		$("body").keydown(function(event) {
			if (event.keyCode == "13") {//keyCode=13是回车键
				$('#login').trigger("click");
			}
		});
		//登录按钮绑定点击事件
		$("#login").click(
				function() {
					var un = $("[name='username']").val();
					var pd = $("[name='password']").val();
					if(un==null||un==""){
						$(".tips_dd_init").show();
						$("p.tips").html("用户名不能为空。");
						return false; 
					}  
					if(pd==null||pd==""){
						$(".tips_dd_init").show();
						$("p.tips").html("密码不能为空。");
						return false;
					}
					$(".tips_dd_init").hide();
					$.post(lemon.config.global.rootUrl + "/user/login", {
						username : un,
						password : $.md5(pd)
					}, function(ret) {
						if (ret != null && ret.status == "1") {
							var date = new Date();
							date.setTime(date.getTime() + 30 * 24 * 60 * 60
									* 1000);//1个月
							$.cookie("un", $("[name='username']").val(), {
								expires : date
							});
							window.location.href = lemon.config.global.rootUrl
									+ "/project/toList";
						} else {
							$(".tips_dd_init").show();
							$("p.tips").html(ret.message);
						}
					}, 'json');

				});
	});
</script>
</head>
<body>
	<form name='loginForm'>
		<dl class="admin_login">
			<dt>
				<strong>接口测试平台</strong> <em>Management System</em>
			</dt>
			<dd class="user_icon">
				<input type="text" placeholder="账号" class="login_txtbx"
					name="username" />
			</dd>
			<dd class="pwd_icon">
				<input type="password" placeholder="密码" class="login_txtbx"
					name="password" />
			</dd>
			<dd class="tips_dd_init">
				<p class="tips" style="color:red"></p>
			</dd>
			<dd>
				<input type="button" value="立即登录" class="submit_btn" id="login"/>
			</dd>
			<dd>
				<p>
					还没账号？<a href="register.html" style="text-decoration: underline;"><strong>去注册</strong></a>
				</p>
			</dd>
		</dl>
	</form>
</body>
</html>
