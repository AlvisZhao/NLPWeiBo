<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.panda.pojo.User"%>
<%
	HttpSession httpSession = request.getSession();
	String purchasePlanCode = request.getParameter("purchasePalnCode");
	User user = (User) httpSession.getAttribute("userInfo");
	request.setAttribute("userRole", user.getRole());
	request.setAttribute("userName", user.getCname());
	request.setAttribute("planCode", purchasePlanCode);
	System.out.println("用户信息：" + user.getRole() + "中文名：" + user.getCname() + purchasePlanCode);
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
		<!-- Google Chrome Frame也可以让IE用上Chrome的引擎: -->
		<meta name="renderer" content="webkit">
		<!--国产浏览器高速模式-->
		<title>采购计划修改</title>

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
		<script src="../framework/cframe.js"></script>
		<!-- 仅供所有子页面使用 -->
		<!-- 公共样式 结束 -->

		<link rel="stylesheet" href="../css/iconfontStyle.css">
		<link rel="stylesheet" href="../css/iconfont.css">
	    <style>
			.box{
			    width:50%; margin-top:10%; margin:auto; padding:28px;
			    height:350px; border:1px #111 solid;
			    display:none;            /* 默认对话框隐藏 */
			}
			.box.show{display:block;} 
			.box .x{ font-size:18px; text-align:right; display:block;}
			#draw_slip{
				display: -moz-box;
				display: -webkit-box;
		   }
		</style>
		
    </head>

	<body>
		<div class="cBody" style="overflow-y: scroll;">
	        <div class="console">
					<div class="layui-form-item">
						<a class="layui-btn" onclick="savePurchasePlanName()"style="margin-left: 30px;width:100px;height:35px;background: #0280A8;"> 保存</a>
						<a class="layui-btn" onclick="purchaseBack()"style="margin-left: 30px;width:100px;height:35px;background: #0280A8;"> 退回</a>
						<a class="layui-btn" onclick="addbasicInfo('basicInfo')"style="margin-left: 30px;width:100px;height:35px;background: #0280A8;"> 提交</a>
						<a class="layui-btn" onclick="printRequest()"style="margin-left: 30px;width:100px;height:35px;background: #0280A8;"> 打印</a>
						<a class="layui-btn" onclick="addbasicInfo('basicInfo')"style="margin-left: 30px;width:100px;height:35px;background: #0280A8;"> 导出</a>
						<a class="layui-btn" onclick="backHomePage()"style="margin-left: 30px;width:100px;height:35px;background: #0280A8;">关闭/退出</a>
					</div>
			</div>
			<div style="width: 100%;height: 5px;background: black;vertical-align: middle;line-height: 50px;background-image: -webkit-gradient(linear,0%0%,100%0%,from(#0280A8),color-stop(0.33,#89CAFF),to(#F1F1F1));"></div>
			<div class="采购计划">
				<div class="xuanze">
					<table style="margin-top: 10px;margin-left: 20px;font-weight: bold;font-size: 15px;">
						<tbody id="purchase1">
							<td>采购计划名称</td>
							<td><input type="text" id="caigou_name" class="layui-input" style="margin-right: 50px;margin-left: 10px;width: 150px;height: 25px;" ></td>
							<td>采购计划编码</td>
							<td><input type="text" id="caigou_code" class="layui-input" style="margin-left: 10px;margin-right: 55px;font-weight: bold;width: 150px;height: 25px;"  disabled="disabled"></td>
							<td>审批状态</td>
							<td><input type="text" id="shengpi_stusta" class="layui-input" style="margin-left: 10px;font-weight: bold;width: 150px;height: 25px;"  disabled="disabled"></td>
						</tbody>
					</table>
					<table style="margin-top: 10px;margin-left: 49px;font-weight: bold;font-size: 15px;">
						<tbody id="modifyPlan">
							<tr>
								<td>修改原因</td>
								<td><input type="text" id="change_reason" class="layui-input" style="margin-right: 95px;margin-left: 10px;width: 150px;height: 25px;"></td>
								<td>修改人</td>
								<td><input type="text" id="change_people" class="layui-input" style="margin-right: 58px;margin-left: 10px;font-weight: bold;width: 150px;height: 25px;"  disabled="disabled"></td>
								<td>修改时间</td>
								<td><input type="text" id="change_time" class="layui-input" style="margin-right: 30px;margin-left: 10px;font-weight: bold;width: 150px;height: 25px;"  disabled="disabled"></td>
							</tr>
						</tbody>	
					</table>
					<table style="margin-top: 10px;margin-left: 64px;font-weight: bold;font-size: 15px;">
						<tbody id="purchase2">
								<td>制单人</td>
								<td><input type="text" id="prepared_by" class="layui-input" style="margin-right: 80px;margin-left: 10px;font-weight: bold;width: 150px;height: 25px;"  disabled="disabled"></td>
								<td>制单时间</td>
								<td><input type="text" id="biling_date" class="layui-input" style="margin-right: 28px;margin-left: 10px;font-weight: bold;width: 150px;height: 25px;"  disabled="disabled"></td>
								<td>采购计划类型</td>
								<td><input type="text" id="shopping_type" class="layui-input" style="margin-right: 30px;margin-left: 10px;font-weight: bold;width: 150px;height: 25px;"  disabled="disabled"></td>
						</tbody>
					</table>
					<div class="biao" style="width: 500px; height: 200px;background: whitesmoke;margin-left: 100px;margin-top: 10px;">
						<table id = "process_Info" class="layui-table" style="font-weight: bold;color: #000000;">
							<tr>
								<thead>
									<th>行号</th>
									<th>审批人</th>
									<th>审批时间</th>
									<th>审批意见</th>
									<th>说明</th>
								</thead>
								<tbody id="appovalPlan">
									<th>1</th>
									<th>chengyong</th>
									<th>2019.06.23</th>
									<th>meiyou</th>
									<th>hahah</th>
								</tbody>
							</tr>
						</table>
					</div>	
			    </div>
			</div>
			<div class="layui-tab" lay-filter="myPage" style="overflow: auto;">
				<div class="layui-tab-content" id="draw_slip">
					<div class="layui-tab-item layui-show" >
						<table id="basicInfo" class="layui-table" >
							<thead>
								<tr>
									<th>行号</th>
									<th>物料分类编码</th>
									<th>物料分类名称</th>
									<th>物料编码</th>
									<th>物料名称</th>
									<th>规格</th>
									<th>型号</th>
									<th>单位</th>
									<th>需求数量</th>
									<th>需求月份</th>
									<th>需求日期</th>
									<th>货源是否确定</th>
									<th>固定供应商</th>
									<th>期望供应商</th>
									<th>所属需求部门</th>
									<th>所属需求计划编码</th>
									<th>采购数量</th>
									<th>采购日期</th>
									<th>计划来源</th>
									<th>物料追踪码</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="purchase3">
								<td>1</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>行号</td>
								<td>修改<td>
							</tbody>
					</table>
				    </div>
			    </div>
			</div>
		</div>
		<input id="role" value="${userRole}" hidden="true" />
		<input id="planCode" value="${planCode}" hidden="true" />
		<input id="cName" value="${userName}" hidden="true" />
	</body>
	
	<!--判断条件-->
		<script type="text/javascript">
			queryPurchase();
			function queryPurchase(){
				var purchasePlanCode = $("#planCode").val();
				var data = {
					"purchasePlanCode" : purchasePlanCode
				}
				$.ajax({
					url: "http://localhost:8080/Batik/purchase/queryPurchase",
					type: "POST",
					data: data,
					dataType: "json",
					success: function(ret) {
						console.log(JSON.stringify(ret));
						if(ret.status == "1") {
							alert("查询成功！");
							showPurchaseList(ret.data);
							getModifyPlan();
							getAppovalPlan();
						}
						
					}
				});
			}
			function showPurchaseList(list){
				$("#purchase1").empty();
				$("#purchase2").empty();
				$("#purchase3").empty();
				var html1 = '';
				var html2 = '';
				var html3 = '';
				for (var i = 0; i < list.length; i++) {
					var planName = list[i].purchasePlanName;
					if (planName == null){
						planName = "暂无数据，请写入！";
					}
					html1 += '<td>采购计划名称</td>'
						  +  '<td><input class="layui-input" type="text" id="planName" style="margin-right: 60px;margin-left: 10px;" value="' + planName + '"/>'
						  +  '</td>'
						  +  '<td>采购计划编码</td>'
						  +  '<td><input class="layui-input" type="text" id="purchasePlanCode" style="margin-left: 10px;margin-right: 30px;background-color: #EEEEEE;font-weight: bold;" value="' + list[i].purchasePlanCode + '"/>'
						  +  '</td>'
						  +  '<td>审批状态</td>'
						  +  '<td><input class="layui-input" type="text" id="shengpi_stusta" style="margin-left: 10px;background-color: #EEEEEE;font-weight: bold;" value="' + list[i].approvalStatus + '"/>'
						  +  '</td>';
					html2 += '<td>制单人</td>'
						  +  '<td><input class="layui-input" type="text" id="prepared_by" style="margin-right: 40px;margin-left: 10px;background-color: #EEEEEE;font-weight: bold;" value="' + list[i].originator + '"/>'
						  +  '</td>'
						  +  '<td>制单时间</td>'
						  +  '<td><input class="layui-input" type="text" id="biling_date" style="margin-right: 40px;margin-left: 10px;background-color: #EEEEEE;font-weight: bold;" value="' + list[i].makingTime + '"/>'
						  +  '</td>'
						  +  '<td>采购计划类型</td>'
						  +  '<td><input class="layui-input" type="text" id="shopping_type" style="margin-right: 30px;margin-left: 10px;background-color: #EEEEEE;font-weight: bold;" value="' + list[i].purchasePlanType + '"/>'
						  +  '</td>';
					html3 += '<th style="width: auto;">' + parseInt(i+1) + '</th>'
						  +    '<th style="width: auto;">' + list[i].classificationCode + '</th>'
						  +    '<th style="width: auto;">' + list[i].classificationName + '</th>'
						  +    '<th style="width: auto;">' + list[i].materialCode + '</th>'
						  +    '<th style="width: auto;">' + list[i].materialName + '</th>'
						  +    '<th style="width: auto;">' + list[i].specification + '</th>'
						  +    '<th style="width: auto;">' + list[i].type + '</th>'
						  +    '<th style="width: auto;">' + list[i].unit + '</th>'
						  +    '<th style="width: auto;">' + list[i].quantity + '</th>'
						  +    '<th style="width: auto;">' + list[i].requestMonth + '</th>'
						  +    '<th style="width: auto;">' + list[i].requestDate + '</th>'
						  +    '<th style="width: auto;">' + list[i].sureSource + '</th>'
						  +    '<th style="width: auto;">' + list[i].wishSupplier + '</th>'
						  +    '<th style="width: auto;">' + list[i].fixedSupplier + '</th>'
						  +    '<th style="width: auto;">' + list[i].requestDeportment + '</th>'
						  +    '<th style="width: auto;">' + list[i].requestPlanCode + '</th>'
						  +    '<th style="width: auto;">' + list[i].supplyQuantity + '</th>'
						  +    '<th style="width: auto;">' + list[i].purchaseDate + '</th>'
						  +    '<th style="width: 15%;">物资需求</th>'
						  +    '<th style="width: auto;">' + list[i].materialTrackingCode + '</th>'
						  +    '<th style="width: auto;"><font onclick="" >修改</font></th>';
				}	 
				$("#purchase1").html(html1);
				$("#purchase2").html(html2);
				$("#purchase3").html(html3);
			}
			function savePurchasePlanName(){
				alert("保存已被点击！");
				var planName = document.getElementById("planName").value;
				if (planName == null || planName == "暂无数据，请写入！"){
					alert("请输入采购计划名称");
				}
				var planCode = document.getElementById("planCode").value;
				alert("已拿到前端数据" + planCode + " 和 " + planName)
				var data = {
					"requestPlanCode" : planCode,
					"purchasePlanName" : planName
				}
				console.log(JSON.stringify(data))
				$.ajax({
					type:"post",
					url:"http://localhost:8080/Batik/purchase/updatePlanName",
					data : data,
					dataType : "json",
					success : function(ret){
						console.log(JSON.stringify(ret));
						if(ret.status == "1"){
							alert("存储成功，正在更新数据...");
							queryPurchase();
						}
					}
				});
			}
			
			function getModifyPlan(){
				var purchasePlanCode = document.getElementById("purchasePlanCode").value;
				var data = {
					"purchasePlanCode" : purchasePlanCode
				}
				console.log(JSON.stringify(data))
				$.ajax({
					type:"post",
					url:"http://localhost:8080/Batik/purchase/getModifyPurchase",
					data: data,
					dataType:"json",
					success: function(ret) {
						console.log(JSON.stringify(ret));
						if(ret.status == "1") {
							showModifyPlan(ret.data);
						}
					}
				});				
				
			}
			function showModifyPlan(list){
				$("#modifyPlan").empty();
				var html = '';
				for (var i = 0; i < list.length; i++) {
					html += '<tr>'
					     +  '<td>' + list[i].modifyReason
						 +  '</td>'
						 +  '<td>' + list[i].modifyPerson
						 +  '</td>'
						 +  '<td>' + list[i].modifyTime
						 +  '</td>'
						 +  '</tr>';
				}
				$("#modifyPlan").html(html);
				
			}
			function getAppovalPlan(){
				var planCode = document.getElementById("planCode").value;
				var data = {
					"planCode" : planCode
				}
				$.ajax({
					type:"post",
					url:"http://localhost:8080/Batik/purchase/getApproval",
					data:data,
					dataType:"json",
					success: function(ret) {
						console.log(JSON.stringify(ret));
						if(ret.status == "1") {
							showApprovalPlan(ret.data);
						}
					}
				});
			}
			function showApprovalPlan(list){
				$("#appovalPlan").empty();
				var html = '';
				for (var i = 0; i < list.length; i++) {
					html += '<tr>'
						 +  '<th>' + parseInt(i+1) + '</th>'
						 +  '<th>' + list[i].approvalPerson + '</th>'
						 +  '<th>' + list[i].approvalTime + '</th>'
						 +	'<th>' + list[i].approvalOpinion + '</th>'
						 +	'<th>' + list[i].approvalExplain + '</th>'
						 +  '</tr>';
				}
				$("#appovalPlan").html(html);
			}
			
			function purchaseBack(){
				var requestPlanCode = document.getElementById("planCode").value;
				alert("已经拿到前端的需求计划编码 " + requestPlanCode);
				var data = {
					"requestPlanCode" : requestPlanCode
				}
				console.log(JSON.stringify(data));
				alert("退回按钮被点击");
				$.ajax({
					type:"post",
					url:"http://localhost:8080/Batik/purchase/purchaseBack",
					data : data,
					dataType:"json",
					success:function(ret){
						console.log(JSON.stringify(ret));
						if (ret.status == "1"){
							alert("退回成功");
						}
					}
				});
			}
			/**
			 * 打印函数
			 */
			function printRequest(){
				alert("打印被点击");
				var requestPlanCode = document.getElementById("requestPlanCode").value;
				var planCode = '';
				var data = {
					"requestPlanCode" : requestPlanCode
				}
				console.log(JSON.stringify(data));
				$.ajax({
					type:"post",
					url:"http://localhost:8080/Batik/purchase/getPurchasePlanCode",
					data: data,
					dataType:"json",
					success:function(ret){
						console.log(JSON.stringify(ret));
						if (ret.status == "1") {
							alert("查询成功");
							planCode += ret.data;
						} else{
							alert("查询失败");
						}
					}
				});
				var url = "../outPrintData.jsp?planCode=" + planCode;
				window.location.href = url;
			}
			
			function backHomePage(){
				window.location.href = "HomePage.html"
			}
		</script>
</html>