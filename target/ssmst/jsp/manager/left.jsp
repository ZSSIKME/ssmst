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
    <div class="list-group-item"><b><a href="${pageContext.request.contextPath }/comm/stuinfo" style="font-family: 黑体;font-size: larger" target="main" id="submit">个人中心</a></b></div>
</div>
<div class="list-group">
    <div class="list-group-item"><b style="font-family: 黑体;font-size: larger">社团管理</b></div>
    <a href="${pageContext.request.contextPath }/comm/myorginfo" class="list-group-item" target="main">我加入的社团</a>
    <a href="${pageContext.request.contextPath }/comm/myapply" class="list-group-item" target="main">我申请的社团</a>
    <a href="${pageContext.request.contextPath }/comm/mycreateorg" class="list-group-item" target="main">我创建的社团</a>
    <a href="/goods/showall" class="list-group-item" target="main">社团物品管理</a>
    <a href="/stu/showstudents" class="list-group-item" target="main">所有成员</a>
</div>
<div class="list-group">
    <div class="list-group-item"><b><a href="${pageContext.request.contextPath }/comm/orglist" style="font-family: 黑体;font-size: larger" target="main">所有社团</a></b></div>
</div>

<div class="list-group">
    <div class="list-group-item"><b style="font-family: 黑体;font-size: larger">活动管理</b></div>
    <a href="${pageContext.request.contextPath }/comm/myact" class="list-group-item" target="main">我参加的活动</a>
    <a href="${pageContext.request.contextPath }/comm/actlist" class="list-group-item" target="main">所有活动</a>
    <a href="/act/myact" class="list-group-item" target="main">发布的活动</a>
</div>

<div class="list-group">
    <div class="list-group-item"><b><a href="/org/apply_stu_list" style="font-family: 黑体;font-size: larger" target="main">申请信息</a></b></div>
</div>

<div class="list-group">
    <div class="list-group-item"><b><a href="${pageContext.request.contextPath }/comm/mynews" style="font-family: 黑体;font-size: larger" target="main">我的通知</a></b></div>
    <div class="list-group-item"><b><a href="/news/myNews" style="font-family: 黑体;font-size: larger" target="main">发布的通知</a></b></div>
</div>

</div>
</body>
<script>
</script>
</html>