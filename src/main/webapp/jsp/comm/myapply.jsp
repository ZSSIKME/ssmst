<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/4
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我申请的社团</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        function cancelapply(org_id) {
            $.ajax({
                type:"DELETE",
                url:"/org/cencel",
                data:{org_id:org_id},
                success:function (msg) {
                    if (msg){
                        alert("取消成功");
                        window.location.href="/comm/myapply";
                    }else {
                        alert("取消失败，请稍后再试！");
                        window.location.href="/comm/myapply";
                    }
                }
            })
        }
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">我申请的社团</h1>
<table class="table table-hover table-condensed table-bordered table-striped" style="table-layout:fixed">
    <thead>
    <tr>
        <td>社团名称</td>
        <td>社团简介</td>
        <td>社团创建时间</td>
        <td>状态</td>
        <td>操作</td>
    </tr>
    </thead>

    <c:forEach items="${applyOrgs}" var="org">
        <tr>
            <td>${org.organization.name}</td>
            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${org.organization.info}</td>
            <td>${org.organization.create_time}</td>
            <td>${org.stu_statu==1?"正常":"审核中"}</td>
            <td><button class="btn-danger" onclick="cancelapply('${org.stu_org}')">取消申请</button> </td>
        </tr>
    </c:forEach>
    <c:if test="${empty applyOrgs}">
        <div>
            <h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #9b9b9b">你暂时还没有社团申请</h1>
        </div>
    </c:if>
</table>
</body>
</html>
