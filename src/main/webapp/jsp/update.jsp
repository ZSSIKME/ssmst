<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/3/28
  Time: 20:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/gVerify.js"></script>
    <style type="text/css">
        * {
            font-family: "微软雅黑";
            letter-spacing: 2px;
        }

        #container {

        }
        #div-bgimg {
            width: 100%;
            height: 100%;
            z-index: -1;
            position: absolute;
            left: 0px;
        }

        #bgimg {
            width: 100%;
            height: 100%;
        }

        #header {
            height: 200px;
        }


        #main {
            height: 366px;
        }

        #main-login {
            border-radius: 3px;
            background-color: rgba(255, 275, 255, .85);
            box-shadow: 7px 7px 10px -3px white;
        }

        #form1 {
            height: 280px;
        }

        #text-account {
            text-indent: 10px;
            width: 60%;
            height: 35px;
            margin: 0px auto;
            position: relative;
            top: 25px;
        }

        #text-password {
            text-indent: 10px;
            width: 60%;
            height: 35px;
            margin: 0px auto;
            position: relative;
            top: 40px;
        }

        #warn {
            text-indent: 10px;
            width: 70%;
            height: 20px;
            text-align:center;
            float:left;
            margin: 0px auto;
            position: absolute;
            top: 276px;
            left:17%;
        }


        #btn-submit {
            width: 20%;
            height: 30px;
            font-size: 15px;
            font-weight: bold;
            color: white;
            background-color: #2E363F;
            position: relative;
            left: 5%;
            top: 65px;
            margin-left: 58px;
        }
        #title {
            text-align: center;
            padding-top: 15px;
            color: #2E363F;
            font-weight: bold;
        }

        #bigtitle {
            font-family: "隶书";
            letter-spacing: 10px;
            padding: 80px;
            display: block;
            margin: 0px auto;
            text-align: center;
            font-size: 90px;
            font-weight: bold;
            color: white;
            text-shadow: 3px 3px 5px #262626;
        }

    </style>
</head>
<body style="background-color: #9d9d9d">
<div class="container-fluid" id="container">

    <div id="div-bgimg">
        <img src="${pageContext.request.contextPath }/static/img/mainbg.jpg"
             id="bgimg" />
    </div>

    <div class="row-fluid">
        <div class="span12" id="header">
            <span id="bigtitle"> 社团管理系统 </span>
        </div>
    </div>
    <div class="row-fluid" id="main">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div id="main-login">
                <h1 id="title">修改密码</h1>
                <a href="javascript:history.back(-1)" class="btn-primary large"><img src="${pageContext.request.contextPath }/static/img/left.jpg" class="img-circle" width="25" height="25"/>返回</a>
                <form id="form1">
                    <input type="password"
                           class="input-group"
                           name="pwd1"
                           id="text-account"
                           onfocus="clearWarning()" placeholder="请输入密码" />
                    <input
                            type="password" class="input-group" name="pwd2"
                            id="text-password" onfocus="clearWarning()" placeholder="请再次输入密码" />
                    <span id="warn" style="color: #ff0000"></span>
                    <input type="button" id="btn-submit" class="btn" onclick="update()" value="确定修改" />
                </form>
            </div>
        </div>
        <div class="col-md-4"></div>
    </div>
</div>
</body>

<script>
    function update() {
        var num=${sessionScope.num};//获取要修改的学生学号
        var pwd1=$("#text-account").val();//第一次输入的密码
        var pwd2=$("#text-password").val();//第二次输入的密码
        if (pwd1==pwd2){//两个密码相同发送请求
            $.ajax({
                type:"PUT",
                url:"/login/updatepwd",
                data:{num:num,pwd:pwd1},
                success:function (msg) {
                    if(msg){
                        alert("密码修改成功，请重新登陆！")
                        window.location.href = "/jsp/login.jsp";
                    }else{
                        //修改密码失败
                        alert("修改密码失败，请稍后再试")
                    }
                }
            })
        }else {//不相同则显示错误
            $("#warn").html("两次密码不相同，请重新输入");
        }
    }

</script>

<!-- 获取焦点自动清除提示信息  -->
<script type="text/javascript">
    function clearWarning(){
        //alert("fuck");
        $("#warn").html("");
    }
</script>
</html>
