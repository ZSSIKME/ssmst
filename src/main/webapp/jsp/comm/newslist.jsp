<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/4
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>消息列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        function newsshow(name,detail) {
            $("#orgName").val(name);
            $("#newsDetail").val(detail);
            $("#newslistmo").modal("show");
        }
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">所有消息</h1>
<div class="col-md-12 input-group input-group-lg">
    <form action="/comm/mynews">

        <input class="text form-control" placeholder="请输入活动社团名字" id="OrgName1" name="OrgName1" style="width: 450px" value="${OrgName1}">
        <%--<input class="text form-control" placeholder="请输入活动社团名字" id="OrgName" name="OrgName" style="width: 220px;margin-left: 10px">
        <input class="text form-control" placeholder="请输入活动管理员名字" id="StuName" name="StuName" style="width: 220px;margin-left: 10px">--%>
        <button class="btn btn-info" role="group" <%--onclick="findorg($('#findorgname').val(),$('#stu_name').val())"--%>
                type="submit"
        >查询</button>
    </form>

</div>
<table class="table table-hover table-condensed table-bordered table-striped" style="table-layout:fixed">
    <thead>
    <tr>
        <td>消息编号</td>
        <td>消息发布社团</td>
        <td>消息内容</td>
        <td>发布时间</td>
        <td>操作</td>
    </tr>
    </thead>
    <c:forEach items="${newslist}" var="news">
        <tr>
            <td>${news.id}</td>
            <td>${news.organization.name}</td>
            <td  style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${news.detail}</td>
            <td>${news.newstime}</td>
            <td><button type="button" class="btn btn-primary" onclick="newsshow('${news.organization.name}','${news.detail}')">
                查看详情
            </button></td>
        </tr>
    </c:forEach>
    <c:if test="${empty newslist}">
        <div>
            <h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #9b9b9b">暂时无消息</h1>
        </div>
    </c:if>
</table>


<div class="modal fade" id="newslistmo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">消息信息</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <label class="col-md-12">社团名称</label>
                    <div class="col-md-12">
                        <input type="text" class="form-control form-control-line" id="orgName" readonly>
                    </div>
                    <label class="col-md-12">通知信息</label>
                    <div class="col-md-12">
                        <%--<input type="test" class="form-control form-control-line" id="newsDetail1" style="height: 150px">--%>
                        <textarea id="newsDetail" rows="20px" cols="60px" readonly></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
