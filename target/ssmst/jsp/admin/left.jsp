<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>左侧导航栏</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body onload="document.getElementById('submit').click()" style="background:transparent;">
<div class="col-md-12" style="height: 40px"></div>
<div class="list-group">
    <div class="list-group-item"><b><a href="${pageContext.request.contextPath }/jsp/admin/admininfo.jsp" style="font-family: 黑体;font-size: larger" target="main" id="submit">个人中心</a></b></div>
</div>
<div class="list-group">
    <div class="list-group-item"><b style="font-family: 黑体;font-size: larger"><a href="${pageContext.request.contextPath }/admin/orgman" style="font-family: 黑体;font-size: larger" target="main">社团管理</a></b></div>
</div>
<div class="list-group">
    <div class="list-group-item"><b style="font-family: 黑体;font-size: larger"><a href="/admin/actlist" style="font-family: 黑体;font-size: larger" target="main">活动管理</a></b></div>
</div>

<div class="list-group">
    <div class="list-group-item"><b style="font-family: 黑体;font-size: larger"><a href="/admin/allstu" style="font-family: 黑体;font-size: larger" target="main">学生管理</a></b></div>
</div>

<div class="list-group">
    <div class="list-group-item"><b style="font-family: 黑体;font-size: larger"><a href="/admin/show_apply_org" style="font-family: 黑体;font-size: larger" target="main">社团申请列表</a></b></div>
</div>

</div>
</body>
<script>
</script>
</html>