<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/4
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的社团信息</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        function showorg_info(org_id,stu_name,stu_phone,stu_classroom,org_name,org_info) {
            $("#org_name").val(org_name);
            $("#org_ids").val(org_id);
            $("#manager_name").val(stu_name);
            $("#manager_clasroom").val(stu_classroom);
            $("#org_info").val(org_info);
            $("#manager_phone").val(stu_phone);

            $("#myorginfomo").modal("show");
        }


        function exitorg(org_id) {
            //alert(org_id);
            $.ajax({
                type:"DELETE",
                url:"/org/exit",
                data: {stu_org:org_id},
                success:function (msg) {
                    if (msg){
                        alert("退出成功");
                        window.location.href="/comm/myorginfo";
                    }else {
                        alert("推出社团失败，请稍后再试！");
                        window.location.href="/comm/myorginfo";
                    }
                }
            })
        }
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">我加入的社团信息</h1>

<%--显示我加入的社团列表，点击后面的按钮显示社团的信息，最后有退出社团按钮，直接退出不必确认--%>
<table class="table table-hover">
    <thead>
    <tr>
        <td>社团id</td>
        <td>社团名称</td>
        <td>社团管理员</td>
        <td>加入时间</td>
        <td>操作</td>
    </tr>
    </thead>

    <c:forEach items="${stu_org}" var="stu_org">
        <tr>
            <td>${stu_org.stu_org}</td>
            <td>${stu_org.organization.name}</td>
            <td>${stu_org.student.name}</td>
            <td>${stu_org.jion_time}</td>
            <td><button type="button" class="btn btn-primary" onclick="showorg_info('${stu_org.stu_org}',
                    '${stu_org.student.name}','${stu_org.student.phone}','${stu_org.student.classroom}','${stu_org.organization.name}',
                    '${stu_org.organization.info}')">
                查看详情
            </button>
            <a type="button" class="btn btn-info" href="/org/stulist?num=${stu_org.stu_org}">查看社团成员</a>
            </td>
        </tr>
        </c:forEach>

</table>

<c:if test="${empty stu_org}">
<div>
    <h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #9b9b9b">你暂时还没有加入社团</h1>
</div>
</c:if>


<%--社团信息模态框--%>

<div class="modal fade" id="myorginfomo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">我的社团详情</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-6">社团编号</label>
                                    <label class="col-md-6">社团名字</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control form-control-line" id="org_ids" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control form-control-line" id="org_name" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">管理员姓名</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="manager_name" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">管理员班级</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="manager_clasroom" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">管理员电话</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="manager_phone" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">社团简介</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="org_info" style="height: 150px" readonly>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-danger" onclick="exitorg($('#org_ids').val(),)">退出社团</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
