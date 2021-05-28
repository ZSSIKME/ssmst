<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/17
  Time: 23:04
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生申请社团的信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        function agree(stu_num,stu_org) {
            $.ajax({
                url:"/org/agree",
                data:{stu_num:stu_num,stu_org:stu_org},
                type: "PUT",
                success:function (msg) {
                    if (msg){
                        alert("操作成功！该同学已加入该社团");
                        window.location.href="/org/apply_stu_list";
                    }else {
                        alert("同意失败，请稍后再试！");
                        window.location.href="/org/apply_stu_list";
                    }
                }
            })
        }

        function refuse(stu_num,stu_org) {
            $.ajax({
                url:"/org/refuse",
                data:{stu_num:stu_num,stu_org:stu_org},
                type: "DELETE",
                success:function (msg) {
                    if (msg){
                        alert("操作成功！已拒绝该学生加入");
                        window.location.href="/org/apply_stu_list";
                    }else {
                        alert("同意失败，请稍后再试！");
                        window.location.href="/org/apply_stu_list";
                    }
                }
            })
        }
    </script>
</head>
<body style="background:transparent;">

<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">申请列表</h1>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <td>学号</td>
                    <td>姓名</td>
                    <td>班级</td>
                    <td>电话</td>
                    <td>申请时间</td>
                    <td>操作</td>
                </tr>
                </thead>
                <c:forEach items="${students.list}" var="stu">
                    <tr>
                        <td>${stu.stu_num}</td>
                        <td>${stu.student.name}</td>
                        <td>${stu.student.classroom}</td>
                        <td>${stu.student.phone}</td>
                        <td>${stu.jion_time}</td>
                        <td><button type="button" class="btn btn-primary" onclick="agree(${stu.stu_num},${stu.stu_org})">
                            同意
                        </button>
                            <button type="button" class="btn btn-danger" onclick="refuse(${stu.stu_num},${stu.stu_org})">
                                拒绝
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${students.pageNum}页，总共${students.pages}页，共${students.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/org/apply_stu_list?pn=1">首页</a> </li>
                    <c:if test="${students.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/org/apply_stu_list?pn=${students.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${students.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/org/apply_stu_list?pn=${page}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${students.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/org/apply_stu_list?pn=${students.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/org/apply_stu_list?pn=${students.pages}">末页</a> </li>

                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
