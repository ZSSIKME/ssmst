<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/17
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>参加该活动的学生列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body style="background:transparent;">
<a href="javascript:history.back(-1)" class="btn-primary large"><img src="${pageContext.request.contextPath }/static/img/left.jpg" class="img-circle" width="25" height="25"/>返回</a>
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">活动成员列表</h1>



<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <td>学生学号</td>
                    <td>学生姓名</td>
                    <td>性别</td>
                    <td>班级</td>
                    <td>签到情况</td>
                </tr>
                </thead>
                <c:forEach items="${stulist}" var="stu">
                    <tr>
                        <td>${stu.stu_num}</td>
                        <td>${stu.student.name}</td>
                        <td>${stu.student.sex}</td>
                        <td>${stu.student.classroom}</td>
                        <td>${stu.sign==1?"已签到":"未签到"}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty stulist}">
                    <h1>没有学生参加该活动</h1>
                </c:if>
            </table>
        </div>
    </div>
</div>

<h3>该活动以共${stulist.size()}位学生</h3>
</body>
</html>
