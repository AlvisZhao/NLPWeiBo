<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.panda.pojo.User"%>
<%
	HttpSession httpSession = request.getSession();
	User user = (User) httpSession.getAttribute("userInfo");
	request.setAttribute("userRole", user.getRole());
	System.out.println("用户信息：" + user.getRole());
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
		<meta name="author" content="穷在闹市" />
		<!-- 作者 -->
		<meta name="revised" content="穷在闹市.v3, 2019/05/01" />
		<!-- 定义页面的最新版本 -->
		<meta name="description" content="网站简介" />
		<!-- 网站简介 -->
		<meta name="keywords" content="搜索关键字，以半角英文逗号隔开" />
		<title>穷在闹市出品</title>

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
			<!--顶部按钮-->
			<div style="width: 100%;height: 60px;margin-top:5px;background: white;vertical-align: middle;line-height: 50px;">
				<a class="layui-btn" onclick="splitPlan()" style="margin-left: 30px;width:90px;height:35px;background: #0280A8;">打印</a>
				<a class="layui-btn" onclick="" style="margin-left: 30px;width:90px;height:35px;background: #0280A8;">导出</a>
				<a class="layui-btn" onclick="requestBack()" style="margin-left: 30px;width:105px;height:35px;background: #0280A8;">撤回</a>
				<a class="layui-btn" onclick="backHomePage()" style="margin-left: 30px;width:105px;height:35px;background: #0280A8;">关闭/退出 </a>

			</div>
			<table class="layui-table">
				<thead>
					<tr>
						<th>行号</th>
						<th>选择</th>
						<th>采购计划编码</th>
						<th>采购计划名称</th>
						<th>采购计划类型</th>
						<th>审批状态</th>
						<th>制单人</th>
						<th>制单时间</th>
						<th style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody id="purchaseData">
					<tr>
						<td>1</td>
						<td>
						<input type="checkbox" name="bianma" onclick="check()";checked>
						</td>
						<td>xxxxxx</td>
						<td>xxx</td>
						<td>xxx</td>
						<td>xx</td>
						<td>xx</td>
						<td>xxx</td>
						<td>
							<a class="layui-btn" onClick="searchPurchaseDetails(1)" style="margin-left: 50px;width:90px;height:35px;background: #0280A8;">查询</a>
							<a class="layui-btn" onclick="modifyPurchaseDetails()" style="margin-left: 30px;width:90px;height:35px;background: #0280A8;">修改</a>
						</td>
					</tr>
					<tr>
						<td>2</td>
						<td>
						<input type="checkbox" name="bianma"  onclick="check()";checked>
						</td>
						<td>xxxxxx</td>
						<td>xxx</td>
						<td>xxx</td>
						<td>xx</td>
						<td>xx</td>
						<td>xxx</td>
						<td>
							<a class="layui-btn" onClick="searchPurchaseDetails()" style="margin-left: 50px;width:90px;height:35px;background: #0280A8;">查询</a>
							<a class="layui-btn" onclick="modifyPurchaseDetails()" style="margin-left: 30px;width:90px;height:35px;background: #0280A8;">修改</a>
						</td>
					</tr>
					<tr>
						<td>3</td>
						<td>
						<input type="checkbox" name="bianma" id="bianma"  onclick="check()";checked>
						</td>
						<td>xxxxxx</td>
						<td>xxx</td>
						<td>xxx</td>
						<td>xx</td>
						<td>xx</td>
						<td>xxx</td>
						<td>
							<a class="layui-btn" onClick="searchPurchaseDetails()" style="margin-left: 50px;width:90px;height:35px;background: #0280A8;">查询</a>
							<a class="layui-btn" onclick="modifyPurchaseDetails()" style="margin-left: 30px;width:90px;height:35px;background: #0280A8;">修改</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<input id="role" value="${userRole}" hidden="true" />
	</body>
	<script type="text/javascript">
			getPurchaseData();
			//获取后台信息
			function getPurchaseData(){
				$.ajax({
					type:"post",
					url:"http://localhost:8080/Batik/purchase/getPurchaseData",
					data : null,
					dataType: "json",
					success: function(ret){
						console.log(JSON.stringify(ret));
						if(ret.status == "1"){
							alert("查询成功，正在调用方法显示");
							showApprovalStatus(ret.data);
						}else{
							alert("查询失败");
						}
					}
				});
				
			}
			
			function showApprovalStatus(list){
				$("#purchaseData").empty();
				html = '';
				for (var i = 0; i < list.length; i ++ ) {
					var status =  parseInt(list[i].approvalStatus);
					var approvalStatus = '';
					switch (status){
						case 6:
							approvalStatus += "未提交";
							break;
						case 7:
							approvalStatus += "采购部主管审批已通过";
							break;
						case 8:
							approvalStatus += "财务部审批已通过";
							break;
					}
					if(i >= 1 && list[i].purchasePlanCode == list[0].purchasePlanCode){
						continue;
					}else{
						html += '<tr>'
						 +  '<td>' + parseInt(i + 1) + '</td>'
						 +  '<td> <input type="checkbox" id="select" name="printPlan" /></td>'
					 	 +  '<td>' + list[i].purchasePlanCode + '</td>'
					 	 +	'<td>' + list[i].purchasePlanName + '</td>'
					 	 +  '<td>' + list[i].purchasePlanType + '</td>'
					 	 +  '<td>' +  approvalStatus  + '</td>'
					 	 +  '<td>' + list[i].originator + '</td>'
					 	 +  '<td>' + list[i].makingTime + '</td>'
					 	 +  '<td>'
						 +	'<font class="layui-btn" onclick="searchPurchaseDetails('+list[i].purchasePlanCode+')" style="margin-left: 50px;width:90px;height:35px;background: #0280A8;">查询</font>';
					 	 var role = $("#role").val();
						if(role != 7){
							html += '<font class="layui-btn" onclick="error()" style="margin-left: 30px;width:90px;height:35px;background: #0280A8;">修改</font>'
						 +  '</td>'
					 	 +  '</tr>'; 
						}else{
							html += '<font class="layui-btn" onclick="modifyPurchaseDetails('+ list[i].purchasePlanCode +')" style="margin-left: 30px;width:90px;height:35px;background: #0280A8;">修改</font>'
						 +  '</td>'
					 	 +  '</tr>'; 
						}
					}
				}
				$("#purchaseData").html(html);
			}
			
			function error(){
				alert("您当前并非采购计划员，不可修改");
			}
			
			function searchPurchaseDetails(code){
				var url = "purchasePlanMainPage2.jsp?purchasePalnCode=" + code;
				window.location.href = url;
			}
			
			function modifyPurchaseDetails(code){
				var url = "purchasePlanMainPage1.jsp?purchasePalnCode=" + code;
				window.location.href = url;
			}
			
			function backHomePage(){
				window.location.href = "HomePage.html";
			}
			
			function requestBack(){
				var role = $("#role").val();
				if(role == 7 || role == 100){
					var checked = [];
					$(":checkbox[name='tableCheckBox']").each(function() {
						if(this.checked) { //复选框选中
							var tr = this.parentNode.parentNode;
							
							
						}
					});
				}
				else{
					alert("你当前不是采购计划员，无法撤回");
				}
			}
			
		</script>

</html>