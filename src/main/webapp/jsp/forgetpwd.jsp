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
    <title>忘记密码</title>
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
            height: 350px;
        }

        #text-account {
            text-indent: 10px;
            width: 60%;
            height: 35px;
            margin: 0px auto;
            position: relative;
            top: 25px;
        }
        #text-cardID {
            text-indent: 10px;
            width: 60%;
            height: 35px;
            margin: 0px auto;
            position: relative;
            top: 40px;
        }

        #text-name {
            text-indent: 10px;
            width: 60%;
            height: 35px;
            margin: 0px auto;
            position: relative;
            top: 55px;
        }
        #text-phone {
            text-indent: 10px;
            width: 60%;
            height: 35px;
            margin: 0px auto;
            position: relative;
            top: 70px;
        }
        #warn {
            text-indent: 10px;
            width: 70%;
            height: 20px;
            text-align:center;
            float:left;
            margin: 0px auto;
            position: absolute;
            top: 340px;
            left:17%;
        }

        #code_input {
            text-indent: 10px;
            width: 30%;
            height: 35px;
            /* margin: 0px auto; */
            position: relative;
            top: 85px;
            left: 50%;
        }

        #btn-submit {
            width: 20%;
            height: 30px;
            font-size: 15px;
            font-weight: bold;
            color: white;
            background-color: #2E363F;
            position: relative;
            left: 30%;
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

<div id="div-bgimg">
    <img src="${pageContext.request.contextPath }/static/img/mainbg.jpg"
         id="bgimg" />
</div>

<div class="container-fluid" id="container">
    <%--    <div id="div-bgimg">
            <img src="${pageContext.request.contextPath }/jsp/img/timg1.jpg"
                 id="bgimg" />
        </div>--%>
    <div class="row-fluid">
        <div class="span12" id="header">
            <span id="bigtitle"> 社团管理系统 </span>
        </div>
    </div>
    <div class="row-fluid" id="main">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div id="main-login">
                <h1 id="title">填写验证信息</h1>
                <a href="javascript:history.back(-1)" class="btn-primary large"><img src="${pageContext.request.contextPath }/static/img/left.jpg" class="img-circle" width="25" height="25"/>返回</a>
                <form id="form1">
                    <input type="text"
                           class="input-group"
                           name="num"
                           id="text-account"
                           onfocus="clearWarning()" placeholder="请输入账号" />
                    <input
                            type="text" class="input-group" name="IdCard"
                            id="text-cardID" onfocus="clearWarning()" placeholder="请输入身份证号" />
                    <input
                            type="text" class="input-group" name="name"
                            id="text-name" onfocus="clearWarning()" placeholder="请输入名字" />
                    <input
                            type="text" class="input-group" name="phone"
                            id="text-phone" onfocus="clearWarning()" placeholder="请输入电话号码" />
                    <input type="text" class="input-group" name="code_input"
                           id="code_input" onfocus="clearWarning()" placeholder="请输入验证码" />
                    <div id="v_container"
                         style="width: 110px; height: 45px; padding-top: 50px; padding-left: 78px"></div>
                    <span id="warn" style="color: #ff0000"></span>
                    <input type="button" id="btn-submit" class="btn" onclick="check()" value="提交验证" />
                </form>
            </div>
        </div>
        <div class="col-md-4"></div>
    </div>
</div>
</body>

<script>
    var verifyCode = new GVerify("v_container");
    //登陆验证
    function check(){
        var num=$("#text-account").val();//学号
        var IdCard=$("#text-cardID").val();//身份证号
        var name=$("#text-name").val();//名字
        var phone=$("#text-phone").val();//电话号码
        var res = verifyCode.validate(document.getElementById("code_input").value);
        if(num == null || num == ""){
            //alert("请输入账号密码！");
            $("#warn").html("请输入账号！");
        }else if(IdCard == null || IdCard == ""){
            $("#warn").html("请输入身份证信息！");
        }else if(name == null || name == ""){
            $("#warn").html("请输入名字！");
        }else if(phone == null || phone == ""){
            $("#warn").html("请输入电话信息！");
        }else{
            if(res){
                $.ajax({
                    type:"POST",
                    url:"/login/forgetpwd",
                    data:{num:num,IdCard:IdCard,name:name,phone:phone},
                    success:function (msg) {
                        if(msg){
                            window.location.href = "/jsp/update.jsp";
                        }else{
                            //登陆失败
                            $("#warn").html("身份验证失败");
                        }
                    }
                })

            }else {
                //验证码不正确，重新输入
                //alert("验证码输入错误，请重新输入！");
                $("#warn").html("<font color='red'>请输入验证码！</font>");
                $("#code_input").val("");
            }
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
