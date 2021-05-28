<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/17
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>社团学生列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">

        function showalterpwd(num,name) {
            $("#stuname").val(name);
            $("#stunum").val(num);
            $("#alterstuinfo").modal("show");
        }

        function saveinfo(name,num,pwd,pwd1) {
            if (pwd!=pwd1){
                $("#warn").html("密码不一致，请重新输入！");
            }else if (pwd==''||pwd1==''){
                $("#warn").html("密码不能为空，请重新输入！");
            } else {
                //alert(name);
                var r = confirm("确定修改"+name+"的密码吗？");
                if (r){
                    $.ajax({
                        url:"/login/updatepwd",
                        data:{num:num,pwd:pwd},
                        type: "PUT",
                        success:function (msg) {
                            if (msg){
                                alert("修改密码成功！");
                                window.location.href="/stu/showstudents";
                            }else {
                                alert("修改密码失败，请稍后再试！");
                                window.location.href="/stu/showstudents";
                            }
                        }
                    })
                }else {
                    window.location.href="/stu/showstudents";
                }

            }
        }

        /*根据学号删除*/
        function delstu_org(stunum) {

            var r = confirm("确定删除吗？");
            if (r){
                $.ajax({
                    url:"/stu/delstu_org",
                    data:{stunum:stunum},
                    type: "DELETE",
                    success:function (msg) {
                        if (msg){
                            alert("删除成功！");
                            window.location.href="/stu/showstudents";
                        }else {
                            alert("删除失败，请稍后再试！");
                            window.location.href="/stu/showstudents";
                        }
                    }
                })
            }else {
                window.location.href="/stu/showstudents";
            }

        }
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">社团成员列表</h1>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">

            <div class="col-md-12 input-group input-group-lg">
                <form action="/stu/showstudents">
                    <input class="text form-control" placeholder="请输入学生名字" id="stu_name1" name="stu_name1" style="width: 350px" value="${stu_name1}">
                    <input class="text form-control" placeholder="请输入班级" id="classroom1" name="classroom1" style="width: 350px;margin-left: 15px" value="${classroom1}">
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
                    <td>班级</td>
                    <td>电话</td>
                    <td>加入时间</td>
                    <td>操作</td>
                </tr>
                </thead>
                <c:forEach items="${studentlist.list}" var="stu">
                    <tr>
                        <td>${stu.stu_num}</td>
                        <td>${stu.student.name}</td>
                        <td>${stu.student.sex}</td>
                        <td>${stu.student.classroom}</td>
                        <td>${stu.student.phone}</td>
                        <td>${stu.jion_time}</td>
                        <td>
                            <button type="button" class="btn btn-primary" onclick="showalterpwd('${stu.stu_num}','${stu.student.name}')">
                                修改密码
                            </button>
                            <button type="button" class="btn btn-danger" onclick="delstu_org('${stu.stu_num}')">删除学生</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${studentlist.pageNum}页，总共${studentlist.pages}页，共${studentlist.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/stu/showstudents?pn=1&stu_name1=${stu_name1}&classroom1=${classroom1}">首页</a> </li>
                    <c:if test="${studentlist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/stu/showstudents?pn=${studentlist.pageNum-1}&stu_name1=${stu_name1}&classroom1=${classroom1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${studentlist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/stu/showstudents?pn=${page}&stu_name1=${stu_name1}&classroom1=${classroom1}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${studentlist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/stu/showstudents?pn=${studentlist.pageNum+1}&stu_name1=${stu_name1}&classroom1=${classroom1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/stu/showstudents?pn=${studentlist.pages}&stu_name1=${stu_name1}&classroom1=${classroom1}">末页</a> </li>

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
                                    <label class="col-md-12">学生姓名</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="stuname">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">学生学号</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="stunum">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">请输入新密码</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="pwd">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">确认密码</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="pwd1">
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
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveinfo($('#stuname').val(),$('#stunum').val(),$('#pwd').val(),$('#pwd1').val())">确定</button>
            </div>
        </div>
    </div>

</div>
</body>
</html>
