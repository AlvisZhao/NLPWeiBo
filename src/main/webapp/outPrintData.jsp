<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.panda.pojo.Purchase"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%
	String planCode = request.getParameter("planCode");
	Date d = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String now = df.format(d);
  	request.setAttribute("planCode", planCode);
  	request.setAttribute("now", now);
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
		<meta name="author" content="小熊猫团队" />
		<!-- 作者 -->
		<meta name="revised" content="小熊猫团队.v3, 2019/05/01" />
		<!-- 定义页面的最新版本 -->
		<meta name="description" content="网站简介" />
		<!-- 网站简介 -->
		<meta name="keywords" content="搜索关键字，以半角英文逗号隔开" />
		<title>小熊猫团队出品</title>

		<!-- 公共样式 开始 -->
		<link rel="stylesheet" type="text/css" href="css/base.css">
		<link rel="stylesheet" type="text/css" href="css/iconfont.css">
		<script type="text/javascript" src="framework/jquery-1.11.3.min.js"></script>
		<link rel="stylesheet" type="text/css" href="layui/css/layui.css">
		<script type="text/javascript" src="layui/layui.js"></script>
		<!-- 滚动条插件 -->
		<link rel="stylesheet" type="text/css" href="css/jquery.mCustomScrollbar.css">
		<script src="framework/jquery-ui-1.10.4.min.js"></script>
		<script src="framework/jquery.mousewheel.min.js"></script>
		<script src="framework/jquery.mCustomScrollbar.min.js"></script>
		<!--<script src="framework/cframe.js"></script>-->
		<!-- 仅供所有子页面使用 -->
		<script src="framework/printThis.js"></script>
		<!-- 公共样式 结束 -->
	</head>

	<body>
		<div class="cBody">
			<div class="console">
				<div class="layui-form-item">
					<a class="layui-btn layui-btn-sm layui-btn-normal" onclick="printTable('dayindaju1')">打印</a>
				</div>
			</div>
			
			<div class="layui-row" id="dayindaju1">
				<table class="layui-table printTable">
					<tbody id="printDataTable">
						<tr>
							<td class="printName" colspan="13">XXX采购计划</td>
						</tr>
						<tr>
							<td class="printDis" colspan="13">
								<span>制单时间：2018-03-09 10:10:29</span>
								<span class="right">采购计划编码：DJ9562154640003</span>
								<span>入库类型：采购入库</span>
							</td>
						</tr>
						<tr>
							<th width="2%" class="textCenter">序号</th>
							<th width="8%">物料分类编码</th>
							<th width="9%" class="textCenter">物料分类名称</th>
							<th width="8%" class="textCenter">物料编码</th>
							<th width="8%" class="textCenter">物料名称</th>
							<th width="8%" class="textCenter">规格</th>
							<th width="8%" class="textCenter">型号</th>
							<th width="8%" class="textCenter">单位</th>
							<th width="8%" class="textCenter">需求月份</th>
							<th width="8%" class="textCenter">需求日期</th>
							<th width="8%" class="textCenter">采购数量</th>
							<th width="8%" class="textCenter">采购日期</th>
							<th width="8%" class="textCenter">计划来源</th>
						</tr>
						<tr>
							<td class="textCenter">1</td>
							<td>不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
							<td class="textCenter">不可编辑</td>
						</tr>
						<tr>
							<td class="printOperator" colspan="13">
								<span class="right">打印日期：2018-03-10 10:24:03</span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<input id="purchasePlanCode" value="${planCode}" hidden="true"/>
		<input id="nowTime" value="${now}" hidden="true"/>
		<script>
			//打印方法
		    function printTable(id){
		    	$('#'+id).printThis({ importCss: true, importStyle: true });
		    }
		</script>
	</body>
	<script type="text/javascript">
		$(function() {
			alert($("#purchasePlanCode").val());
			alert("获取打印数据的方法被调用！！");
			var purchasePlanCode = $("#purchasePlanCode").val();
			var data = {
				"purchasePlanCode" : purchasePlanCode
			}
			console.log(JSON.stringify(data));
			$.ajax({
				type:"post",
				url:"http://localhost:8080/Batik/purchase/getPrintData",
				data : data,
				dataType : "json",
				success : function(ret){
					console.log(JSON.stringify(ret));
					if (ret.status == "1") {
						alert("显示打印数据的方法被调用");
						$("#printDataTable").empty();
						var nowTime = $("#nowTime").val();
						var list = ret.data;
						html = '';
						for (let i = 0; i < list.length; i++) {
							html += '<tr>'
									+  '<td class="printName" colspan="13">'+list[0].purchasePlanName +'</td>'
									+  '</tr>'
									+  '<tr>'
									+  '<td class="printDis" colspan="13">'
									+  '<span>制单时间：' + list[0].purchasePlanName +'</span>'
									+  '<span class="right">采购计划编码：'+ list[0].purchasePlanCode +'</span>'
									+  '<span>入库类型：' + list[0].supplyWay +'</span>'
									+  '</td>'
									+  '</tr>'
									+  '<tr>'
									+  '<th width="2%" class="textCenter">序号</th>'
									+  '<th width="8%">物料分类编码</th>'
									+  '<th width="9%" class="textCenter">物料分类名称</th>'
									+  '<th width="8%" class="textCenter">物料编码</th>'
									+  '<th width="8%" class="textCenter">物料名称</th>'
									+  '<th width="8%" class="textCenter">规格</th>'
									+  '<th width="8%" class="textCenter">型号</th>'
									+  '<th width="8%" class="textCenter">单位</th>'
									+  '<th width="8%" class="textCenter">需求月份</th>'
									+  '<th width="8%" class="textCenter">需求日期</th>'
									+  '<th width="8%" class="textCenter">采购数量</th>'
									+  '<th width="8%" class="textCenter">采购日期</th>'
									+  '<th width="8%" class="textCenter">计划来源</th>'
									+  '</tr>'
									+  '<tr>'
									+  '<td class="textCenter">1</td>'
									+  '<td>'+ list[i].classificationCode +'</td>'
									+  '<td>'+ list[i].classificationNama +'</td>'
									+  '<td>'+ list[i].materialCode +'</td>'
									+  '<td>'+ list[i].materialName +'</td>'
									+  '<td>'+ list[i].specification +'</td>'
									+  '<td>'+ list[i].type +'</td>'
									+  '<td>'+ list[i].unit +'</td>'
									+  '<td>'+ list[i].requestMonth +'</td>'
									+  '<td>'+ list[i].requestDate +'</td>'
									+  '<td>'+ list[i].supplyQuantity +'</td>'
									+  '<td>'+ list[i].purchaseDate +'</td>'
									+  '<td>暂无</td>'
									+  '</tr>'
									+  '<tr>'
									+  '<td class="printOperator" colspan="13">'
									+  '<span class="right">打印日期：' + nowTime +'</span>'
									+  '</td>'
									+  '</tr>';
							$("#printDataTable").html(html);
						} else{
							alert(ret.message);
						}
						}
					
				}
			});
		});
	</script>
</html>