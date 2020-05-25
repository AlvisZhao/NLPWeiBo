<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%
    System.out.println("欢迎来到基于NLP的微博舆情分析系统~");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>登录</title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <style type="text/css">
        html,
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            height: 100%;
            background-image: url(img/LAran3.jpg);
        }

    </style>
</head>

<body>
<div style="width: 100%;height: 100px;background: #2F1154;opacity: 0.8;text-align: center;line-height: 98px;font-size: 45px;color: white">
    基于NLP的微博舆情分析系统
</div>
<div style="margin: 0 auto;width: 30%;height: 50%;margin-top: 7%;border-radius: 12px;
			text-align: center;padding-top: 12px;">
    <div style="width: 100%;margin-top: 48px;color: white;font-size: 18px;">
        <b>登录</b>
    </div>
    <div style="margin-top: 18px;height: 40px;width: 100%;">
        <input id="username" type="text" placeholder="用户名"
               style="outline: none;height: 80%;width: 60%;text-align: center;"/>
    </div>
    <div style="margin-top: 18px;height: 40px;width: 100%;">
        <input id="pwd" type="password" placeholder="密码"
               style="outline: none;height: 80%;width: 60%;text-align: center;"/>
    </div>

    <div>
        <div style="margin-top: 18px;height: 40px;width: 100%;text-align: center;">
            <div onclick="login()"
                 style="margin: 0 auto;height: 100%;line-height: 35px;width: 60%;text-align: center;background: #11298D;border-radius: 5px;color: white;">
                <b>登录</b>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
    window.onload = function() {
        var dragContainer = document.getElementById("dragContainer");
        var dragBg = document.getElementById("dragBg");
        var dragText = document.getElementById("dragText");
        var dragHandler = document.getElementById("dragHandler");
        //滑块最大偏移量
        var maxHandlerOffset = dragContainer.offsetLeft + dragContainer.offsetWidth - dragHandler.offsetWidth;
        //是否验证成功的标记
        var isVertifySucc = false;
        initDrag();
        a=0;
        function initDrag() {
            dragText.textContent = "拖动滑块验证";
            dragHandler.addEventListener("mousedown", onDragHandlerMouseDown);
        }

        function onDragHandlerMouseDown() {
            document.addEventListener("mousemove", onDragHandlerMouseMove);
            document.addEventListener("mouseup", onDragHandlerMouseUp);
        }
        function onDragHandlerMouseMove() {
            /*
            html元素不存在width属性,只有clientWidth
            offsetX是相对当前元素的,clientX和pageX是相对其父元素的
            */
            var left = event.clientX - dragHandler.clientWidth / 2;
            console.log(event.clientX);
            if(left < dragContainer.offsetLeft) {
                left = dragContainer.offsetLeft;
            } else if(left > maxHandlerOffset) {
                left = maxHandlerOffset;
                verifySucc();

            }
            dragHandler.style.left = left - dragContainer.offsetLeft + "px";
            dragBg.style.width = dragHandler.style.left;

        }

        function onDragHandlerMouseUp() {
            document.removeEventListener("mousemove", onDragHandlerMouseMove);
            document.removeEventListener("mouseup", onDragHandlerMouseUp);
            dragHandler.style.left = 0;
            dragBg.style.width = 0;
        }

        //验证成功
        function verifySucc() {
            isVertifySucc = true;
            a=1;
            dragText.textContent = "验证通过";
            dragText.style.color = "white";
            dragHandler.setAttribute("class", "dragHandlerOkBg");
            dragHandler.removeEventListener("mousedown", onDragHandlerMouseDown);
            document.removeEventListener("mousemove", onDragHandlerMouseMove);
            document.removeEventListener("mouseup", onDragHandlerMouseUp);

        }
    }

    document.onkeydown =cdk;
    function cdk(){
        if(event.keyCode ==13){
            login();
        }
    }
    
    //登录
    function login() {
        var username = $("#username").val();
        if(null == username || "" == username) {
            alert("请输入用户名");
            return;
        }
        var pwd = $("#pwd").val();
        if(null == pwd || "" == pwd) {
            alert("请输入密码");
            return;
        }
        var data = {
            "account": username,
            "pwd": pwd
        };
        //关键的一步来了:将前端输入的数据发送给后台控制器，怎么发送？？？
        $.ajax({
            url : "http://localhost:8080/NLPWeiBo/login",
            type : "POST",
            data : data,
            dataType : "json",
            success : function(data) {
                if (data.status == "1") {
                    window.location.href = "frame.jsp";
                }
            }
        });
    }

</script>
</html>