<%--
  Created by IntelliJ IDEA.
  User: 63263
  Date: 2017/3/11
  Time: 17:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String localAddr = request.getLocalAddr(); %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Room</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">

</head>
<body>
<div id="header">
    <div>
        <div>
            <ul>
                <li>
                    <a href="about.html">About</a>
                </li>
            </ul>
            <a href="Login.jsp" id="logo"><p style="text-align:center"><img src="images/home0.jpg" alt="Image" width="370" height="370"></p></a>
            <ul>
                <li>
                    <a href="Login.jsp">Login</a>
                </li>
            </ul>
        </div>
    </div>
    <div>
        <ul>
            <p id="demo">message.</p>
        </ul>
        <p id="demo2">活动用户：</p>
    </div>
</div>
<div id="body">
    <div id="msg">

    </div>

    发送至：<button type="button" id="tar" onclick="order('all')">all</button>
    <input type = "text" id="in" />
    <button type="button" onclick="submit()">提交</button>
    <br />
    <form action="ServiceServlet" method="post">
        <input type="submit" value="联系客服" />
    </form>

</div>
<div id="footer">
    <div>
        <div>
            <a href="#" target="_blank" id="twitter">Twitter</a>
            <a href="#" target="_blank" id="facebook">Facebook</a>
            <a href="#" target="_blank" id="googleplus">Google&#43;</a>
        </div>
        <p>
            &copy; Copyright 2016. All rights reserved |Gourmet Coffee
        </p>
    </div>
</div>
</body>
</html>
<script type = "text/javascript">
    //1.链接到web socket服务器上
    var username = "${sessionScope.username}";
    var localAddr = "<%=localAddr%>";
    if (localAddr == "0:0:0:0:0:0:0:1") localAddr = "localhost";
    var socket = new WebSocket("ws://" + localAddr + ":8080/TestWeb2/chat?username="+username);

    document.getElementById("demo").innerHTML=username;//显示当前用户名

    function submit(){
        var message = document.getElementById("in").value;//获取对话框内信息
        document.getElementById("in").value = "";//清空对话框
        document.getElementById("msg").value = message;//输出信息
        var target1 = document.getElementById("tar").innerHTML;
        var target0 = target1+"00110011"+message;
        socket.send(target0);//发送信息

        socket.onmessage = function (event) {
            console.info(event.data);

            //输出按钮及信息
            var target = event.data.split(":")[0];
            var len = target.length;
            var content = event.data.substring(len);
            if(target=="onLine!"){
                document.getElementById("demo2").innerHTML += content.substring(1)+"; ";
            }else{
                var innerHtmlA = "<button type='button' onclick='order(\"";
                var innerHtmlB = "\");'>";
                document.getElementById("msg").innerHTML += "<br />"+ innerHtmlA + target+ innerHtmlB +target+"</button>"+content;
            }
        }
    }

    function order(target) {
        //响应输出的按钮
        document.getElementById("tar").innerHTML =target;
    }

</script>
