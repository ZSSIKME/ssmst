<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/18
  Time: 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统管理员简介</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        function saveadmin(pwd,pwd1) {
            if (pwd!=pwd1){
                $("#warn").html("密码不一致，请重新输入！");
            }else if (pwd==''||pwd1==''){
                $("#warn").html("密码不能为空，请重新输入！");
            } else{
                //alert("成功！");
                $.ajax({
                    type:"PUT",
                    url:"/admin/alterinfo",
                    data: {pwd:pwd},
                    success:function (msg) {
                        if (msg){
                            alert("修改成功,请重新登录");
                            //window.parent.location.href="/out";
                            window.location.href="${pageContext.request.contextPath }/jsp/admin/admininfo.jsp";
                        }else {
                            alert("修改失败，请稍后再试！");
                        }
                    }
                })
            }
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
                        <h4 class="card-title m-t-10">${sessionScope.username}</h4>
                        <h6 class="card-subtitle">欢迎登录社团管理系统</h6>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#alteradmin">
                            修改信息和密码
                        </button>
                    </center>
                </div>
            </div>
        </div>


        <div class="col-lg-8 col-xlg-9 col-md-7">
            <div class="card">
                <div class="card-block">
                    <form class="form-horizontal form-material">
                        <div class="form-group">
                            <label class="col-md-12">管理员账号</label>
                            <div class="col-md-12">
                                <input type="text" class="form-control form-control-line" value="${sessionScope.username}" readonly>
                            </div>
                        </div>
                        <div class="textarea">
                            <h3>
                                欢迎系统管理员登录，系统管理员有很多的权限，请谨慎操作。
                            </h3>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="alteradmin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                                    <label class="col-md-12">管理员名字</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" value="${sessionScope.username}" id="name" readonly>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-md-12">密码</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="pwd">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">确认密码</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="pwd1">
                                    </div>
                                </div>
                                <div class="warning col-md-offset-4">
                                    <span id="warn" style="color: #ff0000;text-align: center"></span>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveadmin($('#pwd').val(),$('#pwd1').val())">保存</button>
            </div>
        </div>
    </div>

</div>
</body>
</html>
