<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
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
        td:nth-child(2n){
            padding-left: 16px;
        }
        #bgimg {
            width: 100%;
            height: 100%;
        }
        #header {
            height: 100px;
        }
        #footer {
            height: 165px;
        }
        #main-login {
            border-radius: 3px;
            background-color: rgba(255, 275, 255, .85);
            box-shadow: 7px 7px 10px -3px white;
        }
        #main {
            height: 366px;
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

        #user_reg{
            font-family: 微软雅黑;
            font-size: 40px;
            text-align: center;
            margin-top: 110px;
        }
        #form{
            width: 100%; /*设置宽度，方便使其居中*/
            color: #e5e7e8;
            margin: 40px auto auto 75px;	/*上右下左*/
            font-size: 25px;
            padding-bottom: 15px;
        }
        input{
            height: 30px;
            width: 20em;
            margin-top: 8px;
            margin-bottom: 8px;
        }
        /*input标签下的属性选择器*/
        input[type="submit"],input[type="reset"]{
            height: 25px;
            width: 5em;
            margin-top: 5px;
            margin-left: 6px;
        }
    </style>
</head>
<script>
function checknum(num) {
    var reg=/^\d{10}$/;
    if (num!=""&&num.search(reg)!=-1){
        sta=1;
        $("#test_num").html("<font color='green' size='3px'>学号格式正确</font>");
    }else {
        $("#test_num").html("<font color='red' size='3px'>学号格式不正确</font>");
    }
}
function checkname(name) {
    var reg=/^[\u4E00-\u9FA5A-Za-z]{2,20}/;
    if (name!=""&&name.search(reg)!=-1){
        $("#test_name").html("<font color='green' size='3px'>姓名格式正确</font>");
    }else {
        $("#test_name").html("<font color='red' size='3px'>姓名格式不正确</font>");
    }
}
function checkclassroom(classroom) {
    var reg=/^[\u4E00-\u9FA5A-Za-z0-9]{2,30}/;
    if (classroom!=""&&classroom.search(reg)!=-1){
        $("#test_classroom").html("<font color='green' size='3px'>班级格式正确</font>");
    }else {
        $("#test_classroom").html("<font color='red' size='3px'>班级格式不正确</font>");
    }
}
function checkage(age) {
    var reg=/^(?:0|[1-9][0-9]?|100)$/;
    if (age!=""&&age.search(reg)!=-1){
        $("#test_age").html("<font color='green' size='3px'>年龄格式正确</font>");
    }else {
        $("#test_age").html("<font color='red' size='3px'>年龄格式不正确</font>");
    }
}
function checkidcard(IdCard) {
    var reg=/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    if (IdCard!=""&&IdCard.search(reg)!=-1){
        $("#test_IdCard").html("<font color='green' size='3px'>身份证格式正确</font>");
    }else {
        $("#test_IdCard").html("<font color='red' size='3px'>身份证格式不正确</font>");
    }
}
function checkphone(phone) {
    var reg=/^1\d{10}$/;
    if (phone!=""&&phone.search(reg)!=-1){
        $("#test_phone").html("<font color='green' size='3px'>电话格式正确</font>");
    }else {
        $("#test_phone").html("<font color='red' size='3px'>电话格式不正确</font>");
    }
}
function checkpassword(password) {
    var reg=/^[\u4E00-\u9FA5A-Za-z0-9_]{2,20}/;
    if (password!=""&&password.search(reg)!=-1){
        $("#test_password").html("<font color='green' size='3px'>密码格式正确</font>");
    }else {
        $("#test_password").html("<font color='red' size='3px'>密码格式不正确</font>");
    }
}
//验证两次输入的密码是否一样
function validate_password2(password2) {
    var password = $("#password").val();
    if (password2 == "") {
        $("#is_test_pw").html("<font color='red' size='3px'>密码不能为空</font>");
    } else if (password == password2) {
        $("#is_test_pw").html("<font color='green' size='3px'>√两次输入的密码相同</font>");
    } else {
        $("#is_test_pw").html("<font color='red' size='3px'>两次输入的密码不同</font>");
    }
}

//函数4：验证表单是否已经填好
function validate_form(){
    var num=$("#num").val();
    var name=$("#name").val();
    var classroom=$("#classroom").val();
    var age=$("#age").val();
    var IdCard=$("#IdCard").val();
    var phone=$("#phone").val();
    var password=$("#password").val();
    var password2 = $("#password2").val();

    var numreg=/^\d{10}$/;
    var namereg=/^[\u4E00-\u9FA5A-Za-z]{2,20}/;
    var classroomreg=/^[\u4E00-\u9FA5A-Za-z0-9]{2,30}/;
    var agereg=/^(?:0|[1-9][0-9]?|100)$/;
    var idcardreg=/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    var phonereg=/^1\d{10}$/;
    var passwordreg=/^[\u4E00-\u9FA5A-Za-z0-9_]{2,20}/;

    if (num!=""&&numreg.test(num)
    &&name!=""&&namereg.test(name)
    &&classroom!=""&&classroomreg.test(classroom)
    &&age!=""&&agereg.test(age)
    &&IdCard!=""&&idcardreg.test(IdCard)
    &&phone!=""&&phonereg.test(phone)
    &&password!=""&&passwordreg.test(password)
    &&password2!=""){
        alert("信息填写正确。可以提交，请确认");
        return true;
    }else {
        alert("信息不完整，请查证后重新提交");
        return false;
    }
}
</script>

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
        <div class="col-md-5">
            <div id="main-login">
                <div class="col-md-12" style="height: 15px"></div>
                <div id="user_reg">用户注册</div>
                <a href="javascript:history.back(-1)" class="btn-primary large"><img src="${pageContext.request.contextPath }/static/img/left.jpg" class="img-circle" width="25" height="25"/>返回</a>
                <form action="/regist/add" method="post" id="form">
                    <table>
                        <tr>
                            <td style="width: 60px">学号</td>
                            <td style="size: 100px"><input type="text" id="num" name="num" placeholder="请输入10位学号" onblur="checknum(this.value)"/></td>
                            <td id="test_num" style="width: 60px"></td>
                        </tr>
                        <tr>
                            <td>姓名</td>
                            <td><input type="text" id="name" name="name" placeholder="请输入名字" onblur="checkname(this.value)"/></td>
                            <td id="test_name"></td>
                        </tr>
                        <tr>
                            <td>班级</td>
                            <td><input type="text" id="classroom" name="classroom" placeholder="请输入班级" onblur="checkclassroom(this.value)"/></td>
                            <td id="test_classroom"></td>
                        </tr>
                        <tr>
                            <td>年龄</td>
                            <td><input type="text" id="age" name="age" placeholder="请输入年龄" onblur="checkage(this.value)"/></td>
                            <td id="test_age"></td>
                        </tr>
                        <tr>
                            <td>身份证号</td>
                            <td><input type="text" id="IdCard" name="IdCard" placeholder="请输入身份证信息" onblur="checkidcard(this.value)"/></td>
                            <td id="test_IdCard"></td>
                        </tr>
                        <tr>
                            <td>电话号码</td>
                            <td><input type="text" id="phone" name="phone" placeholder="请输入电话号码" onblur="checkphone(this.value)"/></td>
                            <td id="test_phone"></td>
                        </tr>
                        <tr>
                            <td>密码</td>
                            <td><input type="password" id="password" name="pwd" placeholder="请输入密码" onblur="checkpassword(this.value)"/></td>
                            <td id="test_password"></td>
                        </tr>
                        <tr>
                            <td>确认密码</td>
                            <td><input type="password" id="password2" name="pwd2" placeholder="请确认密码"onblur="validate_password2(this.value)" /></td>
                            <td id="is_test_pw"></td>
                        </tr>
                        <tr>
                            <td>性别</td>
                            <td>
                                <label>男</label>
                                <input  name="sex" value="男" type="radio" checked="checked"style="width: 30px">
                                <label>女</label>
                                <input name="sex" value="女" type="radio" style="width: 30px">
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td style="margin-top: 5px"><input class="btn-primary" type="submit" id="submit_form" value="注册" onclick="return validate_form()"/>
                                <input class="btn-danger" type="reset" value="重置"/>
                            </td>
                        </tr>
                </table>
            </form>
                <div class="col-md-12" style="height: 16px"></div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
</div>
</body>
</html>
