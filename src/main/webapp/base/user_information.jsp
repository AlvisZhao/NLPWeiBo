<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.panda.pojo.User"%>
<%
	HttpSession httpSession = request.getSession();
	User user = (User) httpSession.getAttribute("userInfo");
	request.setAttribute("userRole", user.getRole());
	request.setAttribute("userCname", user.getCname());
	request.setAttribute("userAccount", user.getAccount());
	request.setAttribute("userMobile", user.getMobile());
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
		<!-- Google Chrome Frame也可以让IE用上Chrome的引擎: -->
		<meta name="renderer" content="webkit">
		<!--国产浏览器高速模式-->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="author" content="Panda团队" />
		<!-- 作者 -->
		<meta name="revised" content="Panda团队.v3, 2019/05/01" />
		<!-- 定义页面的最新版本 -->
		<meta name="description" content="网站简介" />
		<!-- 网站简介 -->
		<meta name="keywords" content="搜索关键字，以半角英文逗号隔开" />
		<title>Panda团队出品</title>

		<!-- 公共样式 开始 -->
		<link rel="stylesheet" type="text/css" href="../css/base.css">
		<link rel="stylesheet" type="text/css" href="../css/iconfont.css">
		<script type="text/javascript" src="../framework/jquery-1.11.3.min.js"></script>
		<link rel="stylesheet" type="text/css" href="../layui/css/layui.css">
		<script type="text/javascript" src="../layui/layui.js"></script>
		<!-- 滚动条插件 -->
		<link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css">
		<script src="../framework/jquery-ui-1.10.4.min.js"></script>
		<script src="../framework/jquery.mousewheel.min.js"></script>
		<script src="../framework/jquery.mCustomScrollbar.min.js"></script>
		<script src="../framework/cframe.js"></script><!-- 仅供所有子页面使用 -->
		<!-- 公共样式 结束 -->

	</head>

	<body>
		<div class="cBody">
			<form id="addForm" class="layui-form" action="">
				<div class="layui-form-item">
					<label class="layui-form-label">账号</label>
					<div id="userAccount" class="layui-input-inline shortInput">
						<input type="password" name="oldpassword" required lay-verify="required" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">中文名</label>
					<div id="userCname" class="layui-input-inline shortInput">
						<input required lay-verify="required" autocomplete="off" class="layui-input" disabled="disabled">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">手机号</label>
					<div id="userMobile" class="layui-input-inline shortInput">
						<input required lay-verify="required" autocomplete="off" class="layui-input" disabled="disabled">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">用户角色</label>
					<div id="userRole" class="layui-input-inline shortInput">
						<input required lay-verify="required" autocomplete="off" class="layui-input" disabled="disabled" value="">
					</div>
				</div>
			</form>
		</div>
		<input id="account" value="${userAccount}" hidden="true" />
		<input id="cName" value="${userCname}" hidden="true" />
		<input id="Mobile" value="${userMobile}" hidden="true" />
		<input id="role" value="${userRole}" hidden="true" />
	</body>
	<script type="text/javascript">
		$(function(){
			$("#userAccount").empty();
			$("#userCname").empty();
			$("#userMobile").empty();
			$("#userRole").empty();
			var html1 = '';
			var html2 = '';
			var html3 = '';
			var html4 = '';
			html1 += '<input required lay-verify="required" autocomplete="off" class="layui-input" disabled="disabled" value='+ $("#account").val() +'>';
			html2 += '<input required lay-verify="required" autocomplete="off" class="layui-input" disabled="disabled" value='+ $("#cName").val() +'>';
			html3 += '<input required lay-verify="required" autocomplete="off" class="layui-input" disabled="disabled" value='+ $("#Mobile").val() + '>';
			html4 += '<input required lay-verify="required" autocomplete="off" class="layui-input" disabled="disabled" value='+ $("#role").val() + '>';
			$("#userAccount").html(html1);
			$("#userCname").html(html2);
			$("#userMobile").html(html3);
			$("#userRole").html(html4);	
		});
	</script>
</html>