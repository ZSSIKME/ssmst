<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/18
  Time: 16:19
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
        function del_stu_org(stu_num,org_id) {
            //通过学生学号和社团id删除该学生。
            var b = confirm("是否删除该学生？");
            if (b){
                $.ajax({
                    type: "DELETE",
                    data: {stu_num:stu_num,org_id:org_id},
                    url: "/admin/delorgstu",
                    success:function (msg) {
                        if (msg){
                            alert("删除成功！")
                            window.location.href="/admin/showstus?org_id=${org_id}";
                        }else {
                            alert("删除失败！请稍后再试！")
                            window.location.href="/admin/showstus?org_id=${org_id}";
                        }
                    }
                })
            }
        }
    </script>
</head>
<body style="background:transparent;">
<a href="javascript:history.back(-1)"><img src="${pageContext.request.contextPath }/static/img/left.jpg" class="img-circle" width="25" height="25"/>返回</a>

<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">社团成员列表</h1>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
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
                            <button type="button" class="btn btn-danger" onclick="del_stu_org('${stu.stu_num}','${org_id}')" <c:if test="${stu.roleID==2}">disabled</c:if>>删除学生</button>
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
                    <li class="page-item"><a class="page-link" href="/admin/showstus?org_id=${org_id}&pn=1">首页</a> </li>
                    <c:if test="${studentlist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/showstus?org_id=${org_id}&pn=${studentlist.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${studentlist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/admin/showstus?org_id=${org_id}&pn=${page}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${studentlist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/showstus?org_id=${org_id}&pn=${studentlist.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/admin/showstus?org_id=${org_id}&pn=${studentlist.pages}">末页</a> </li>

                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
