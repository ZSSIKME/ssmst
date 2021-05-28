<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/18
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        function a_delstu(num) {
            var b = confirm("是否确定删除该学生？");
            if (b){
                //删除学生
                $.ajax({
                    type:"DELETE",
                    data:{num:num},
                    url:"/admin/delstu",
                    success:function (msg) {
                        if (msg=="warn"){
                            alert("不能删除社团管理员，应先解散该社团！");
                            window.location.href="/admin/allstu";
                        }else if (msg=="ok") {
                            alert("删除成功！");
                            window.location.href="/admin/allstu";
                        }else {
                            alert("删除失败，请稍后再试！");
                            window.location.href="/admin/allstu";
                        }
                    }
                })
            }else {
                window.location.href="/admin/allstu";
            }

        }

        function a_alterinfo(stunum,stuname,stusex,stuclasstoom,stuage,stuphone,stupwd,stuIdCard) {
            //将学生信息填入到模态框中
            $("#name").val(stuname);
            $("#num").val(stunum);
            $("#phone").val(stuphone);
            $("#idCard").val(stuIdCard);
            $("#pwd").val(stupwd);
            $("#classroom").val(stuclasstoom);
            $("#sex").val(stusex);
            $("#age").val(stuage);

            //展示模态框
            $("#alterstuinfo").modal("show");
        }

        function alterstu_info(name,num,phone,idCard,pwd,classroom,sex,age) {
            $.ajax({
                type:"PUT",
                data:{name:name,num:num,phone:phone,IdCard:idCard,pwd:pwd,classroom:classroom,sex:sex,age:age},
                url:"/admin/alterstuinfo",
                success:function (msg) {
                    if (msg){
                        alert("修改成功！");
                        window.location.href="/admin/allstu";
                    }else {
                        alert("修改失败，请稍后再试！");
                        window.location.href="/admin/allstu";
                    }
                }
            })
        }


    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">学生列表</h1>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">

            <div class="col-md-12 input-group input-group-lg">
                <form action="/admin/allstu">
                    <input class="text form-control" placeholder="请输入学生名字" id="findstuName" name="findstuName" style="width: 350px" value="${findstuName}">
                    <input class="text form-control" placeholder="请输入班级" id="findstuClass" name="findstuClass" style="width: 350px;margin-left: 15px" value="${findstuClass}">
                    <button class="btn btn-info" role="group" <%--onclick="findorg($('#findorgname').val(),$('#stu_name').val())"--%>
                            type="submit"
                    >查询</button>
                </form>

            </div>

            <table class="table table-hover">
                <thead>
                <tr>
                    <td>学生学号</td>
                    <td>学生姓名</td>
                    <td>学生性别</td>
                    <td>学生班级</td>
                    <td>年龄</td>
                    <td>电话</td>
                    <td>操作</td>
                </tr>
                </thead>
                <c:forEach items="${stulist.list}" var="stu">
                    <tr>
                        <td>${stu.num}</td>
                        <td>${stu.name}</td>
                        <td>${stu.sex}</td>
                        <td>${stu.classroom}</td>
                        <td>${stu.age}</td>
                        <td>${stu.phone}</td>
                        <td hidden>${stu.pwd}</td>
                        <td hidden>${stu.idCard}</td>
                        <td><button type="button" class="btn btn-primary" onclick="a_alterinfo('${stu.num}',
                                '${stu.name}','${stu.sex}','${stu.classroom}','${stu.age}','${stu.phone}','${stu.pwd}','${stu.idCard}')">
                            修改信息
                        </button>
                            <button type="button" class="btn btn-danger" onclick="a_delstu('${stu.num}')">
                            删除学生
                        </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${stulist.pageNum}页，总共${stulist.pages}页，共${stulist.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/admin/allstu?pn=1&findstuName=${findstuName}&findstuClass=${findstuClass}">首页</a> </li>
                    <c:if test="${stulist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/allstu?pn=${stulist.pageNum-1}&findstuName=${findstuName}&findstuClass=${findstuClass}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${stulist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/admin/allstu?pn=${page}&findstuName=${findstuName}&findstuClass=${findstuClass}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${stulist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/allstu?pn=${stulist.pageNum+1}&findstuName=${findstuName}&findstuClass=${findstuClass}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/admin/allstu?pn=${stulist.pages}&findstuName=${findstuName}&findstuClass=${findstuClass}">末页</a> </li>

                </ul>
            </nav>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="alterstuinfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                                        <input type="text" class="form-control form-control-line" id="name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">学号</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="num" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">电话</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="phone">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">身份证号</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="idCard">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">密码</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="pwd">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">班级</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="classroom">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">性别</label>
                                    <label class="col-md-6">年龄</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control form-control-line" id="sex">
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control form-control-line" id="age">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="alterstu_info($('#name').val(),$('#num').val(),$('#phone').val(),$('#idCard').val(),
                $('#pwd').val(),$('#classroom').val(),$('#sex').val(),$('#age').val(),)">保存</button>
            </div>
        </div>
    </div>

</div>
</body>
</html>
