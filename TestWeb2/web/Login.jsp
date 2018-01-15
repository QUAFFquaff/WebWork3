<%--
  Created by IntelliJ IDEA.
  User: 63263
  Date: 2017/3/10
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
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
    </div>
</div>
<div id="body">
    <div>
        <form action="login" method="post">
            name:<input name = "username" /><br /><br />
            password:<input name = "password" />
            <input type="submit" value="登陆"/>
        </form><br />
        <table>
            <tr>
                <td>Chat Room</td>
                <td>: &nbsp;Thinks for your presence!</td>
            </tr>
            <tr>
                <td>Hot line</td>
                <td>: &nbsp;12345678</td>
            </tr>
            <tr>
                <td>E-mail address</td>
                <td>: &nbsp;632633533@qq.com</td>
            </tr>
            <tr>
                <td>Words in the end</td>
                <td>: &nbsp;If you have some advice to us, connect us with e-mail. You will gain reward as long as it is accepted.</td>
            </tr>
        </table>
    </div>
</div>
<div id="footer">
    <div>
        <div>
            <a href="#" target="_blank" id="twitter">Twitter</a>
            <a href="#" target="_blank" id="facebook">Facebook</a>
            <a href="#" target="_blank" id="googleplus">Google&#43;</a>
        </div>
        <p>
            &copy; Copyright 2017. All rights reserved |	Leo Quaff
        </p>
    </div>
</div>
</body>
</html>
<script type = "text/javascript">
    //取出传回来的参数error并与yes比较
    var errori ='<%=request.getParameter("error")%>';
    if(errori=='yes'){
        alert("登录失败!");
    }

</script>