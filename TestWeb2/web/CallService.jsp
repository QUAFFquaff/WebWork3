<%--
  Created by IntelliJ IDEA.
  User: 63263
  Date: 2017/3/12
  Time: 12:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <p id="demo">
                <input id="username">
                <button onclick="getUsername()">输入用户名</button>

            </p>
        </ul>
    </div>
</div>
<div id="body">
    <div id="msg">

    </div><input type = "text" id="in" />
    <button type="button" onclick="submit()">提交</button>
</div>

</body>
</html>
<script type = "text/javascript">
    //1.链接到web socket服务器上
    var socket = new WebSocket("ws://localhost:8080/TestWeb2/chat?username="+username);
    var username ;

    function getUsername() {
        username = document.getElementById("username").value;
        if(username!=null)document.getElementById("demo").innerHTML=username;//显示当前用户名
    }

    function submit(){
        if(username==null){
            alert("请先提交用户名");
        }else{

            var message = document.getElementById("in").value;//获取对话框内信息
            document.getElementById("in").value = "";//清空对话框
            document.getElementById("msg").value = message;//输出信息

            var target0 = "Service"+username+"00110011"+message;
            socket.send(target0);//发送信息

            socket.onmessage = function (event) {
                console.info(event.data);
                var target = event.data.split(":")[0];
                //输出按钮及信息
                if(target=="Service"||target==document.getElementById("demo").innerHTML){
                    document.getElementById("msg").innerHTML += "<br />"+ event.data;
                }
            }
        }
    }


</script>