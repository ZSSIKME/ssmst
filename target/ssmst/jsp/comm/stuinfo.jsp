<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/2
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>学生信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>


    <script type="text/javascript">
        function saveinfo() {
            var num=$("#num").val();
            var name=$("#name").val();
            var sex=$("#sex").val();
            var pwd=$("#pwd").val();
            var classroom=$("#classroom").val();
            var age=$("#age").val();
            var IdCard=$("#idCard").val();
            var phone=$("#phone").val();
            $.ajax({
                type:"PUT",
                url:"/comm/alterinfo",
                data:{num:num,name:name,sex:sex,pwd:pwd,classroom:classroom,age:age,IdCard:IdCard,phone:phone},
                success:function (msg) {
                    if(msg){
                        //页面跳转到成功页面
                        //信息修改成功，重新登录试试吧！
                        alert("信息修改成功，请记住你的密码！");
                        window.location.href="${pageContext.request.contextPath}/comm/stuinfo";
                    }else{
                        //修改失败
                        alert("修改失败，请稍后再试");
                    }
                }
            })
        }
    </script>
</head>

<body style="background:transparent;">

<div class="container-fluid">
    <div class="row">
        <div class="row page-titles">
            <div class="col-md-6 col-8 align-self-center" style="height: 60px">
            </div>
            <div class="col-md-6 col-8 align-self-center">

                <div class="col-md-12" style="height: 40px">
                </div>

            </div>
        </div>
        <div class="col-lg-4 col-xlg-3 col-md-5">
            <div class="card">
                <div class="card-block">
                    <center class="m-t-30"> <img src="${pageContext.request.contextPath }/static/img/stu.jpg" class="img-circle" width="150">
                        <h4 class="card-title m-t-10">${stuinfo.name}</h4>
                        <h6 class="card-subtitle">欢迎登录社团管理系统</h6>
                    </center>
                </div>
            </div>
        </div>


        <div class="col-lg-8 col-xlg-9 col-md-7">
            <div class="card">
                <div class="card-block">
                    <form class="form-horizontal form-material">
                        <div class="form-group">
                            <label class="col-md-12">姓名</label>
                            <div class="col-md-12">
                                <input type="text" class="form-control form-control-line" value="${stuinfo.name}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-12">学号</label>
                            <div class="col-md-12">
                                <input type="test" class="form-control form-control-line" value="${stuinfo.num}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-12">电话</label>
                            <div class="col-md-12">
                                <input type="text" value="${stuinfo.phone}" class="form-control form-control-line" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-12">身份证号</label>
                            <div class="col-md-12">
                                <input type="text" value="${stuinfo.idCard}" class="form-control form-control-line" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-12">密码</label>
                            <div class="col-md-12">
                                <input type="password" class="form-control form-control-line" value="${stuinfo.pwd}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-12">班级</label>
                            <div class="col-md-12">
                                <input type="text" value="${stuinfo.classroom}" class="form-control form-control-line" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-6">性别</label>
                            <label class="col-md-6">年龄</label>
                            <div class="col-md-6">
                                <input type="text" value="${stuinfo.sex}" class="form-control form-control-line" readonly>
                            </div>
                            <div class="col-md-6">
                                <input type="text" value="${stuinfo.age}" class="form-control form-control-line" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#alterinfo">
                                    修改个人信息
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="alterinfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改信息</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-12">姓名</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" value="${stuinfo.name}" id="name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">学号</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="num" value="${stuinfo.num}" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">电话</label>
                                    <div class="col-md-12">
                                        <input type="text" value="${stuinfo.phone}" class="form-control form-control-line" id="phone">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">身份证号</label>
                                    <div class="col-md-12">
                                        <input type="text" value="${stuinfo.idCard}" class="form-control form-control-line" id="idCard">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">密码</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" value="${stuinfo.pwd}" id="pwd">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">班级</label>
                                    <div class="col-md-12">
                                        <input type="text" value="${stuinfo.classroom}" class="form-control form-control-line" id="classroom">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">性别</label>
                                    <label class="col-md-6">年龄</label>
                                    <div class="col-md-6">
                                        <input type="text" value="${stuinfo.sex}" class="form-control form-control-line" id="sex">
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" value="${stuinfo.age}" class="form-control form-control-line" id="age">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveinfo()">保存</button>
            </div>
        </div>
    </div>

</div>
</body>
<script>

</script>
</html>
