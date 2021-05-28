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
    <title>活动列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        <%--点击显示活动信息模态框--%>
        function showactinfo(actid) {
            $.ajax({
                url:"/comm/actinfo",
                type:"GET",
                data:{actid:actid},
                success:function (msg) {
                    if (msg){
                        $("#act_name").val(msg.name);
                        $("#act_id").val(msg.id);
                        $("#manager_phone").val(msg.student.phone);
                        $("#manager_name").val(msg.student.name);
                        $("#manager_clasroom").val(msg.student.classroom);
                        $("#act_place").val(msg.place);
                        $("#act_info").val(msg.info);
                        $("#start_time").val(msg.act_time);
                        $("#end_time").val(msg.act_end_time);


                        $("#actinfo").modal("show");
                    }else {
                        alert("操作失败，请稍后再试！");
                    }
                }
            })
        }

        function joinact(actid) {
            $.ajax({
                type: "POST",
                data: {actid:actid},
                url: "/comm/joinact",
                success:function (msg) {
                    if (msg){
                        alert("加入活动成功！")
                        window.location.href="/comm/actlist";
                    }else {
                        alert("你已经加入该活动，请及时签到！")
                        window.location.href="/comm/actlist";
                    }
                }
            })
        }
        function findact(name) {
            alert(name);
        }

    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">所有活动</h1>


<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 input-group input-group-lg">
            <form action="/comm/actlist">

                <input class="text form-control" placeholder="请输入活动名字" id="ActName" name="ActName" style="width: 220px" value="${ActName}">
                <input class="text form-control" placeholder="请输入活动社团名字" id="OrgName" name="OrgName" style="width: 220px;margin-left: 10px" value="${OrgName}">
                <input class="text form-control" placeholder="请输入活动管理员名字" id="StuName" name="StuName" style="width: 220px;margin-left: 10px" value="${StuName}">
                <button class="btn btn-info" role="group" <%--onclick="findorg($('#findorgname').val(),$('#stu_name').val())"--%>
                        type="submit"
                >查询</button>
            </form>

        </div>
        <div class="col-md-12">
            <table class="table table-hover table-condensed table-bordered table-striped" style="table-layout:fixed">
                <thead>
                <tr>
                    <td>活动编号</td>
                    <td>活动名称</td>
                    <td>活动简介</td>
                    <td>活动负责人</td>
                    <td>活动组织社团</td>
                    <td>活动地点</td>
                    <td>操作</td>
                </tr>
                </thead>

                <c:forEach items="${actlist.list}" var="act">
                    <tr>
                        <td id="actid">${act.id}</td>
                        <td>${act.name}</td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${act.info}</td>
                        <td>${act.student.name}</td>
                        <td>${act.organization.name}</td>
                        <td>${act.place}</td>
                        <td><button class="btn-primary" onclick="showactinfo('${act.id}')">查看详情</button> </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty actlist.list}">
                    <div>
                        <h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #9b9b9b">暂时无活动</h1>
                    </div>
                </c:if>
            </table>
        </div>
    </div>

    <%--分页--%>
    <div class="row">
        <div class="col-md-6">
            当前第${actlist.pageNum}页，总共${actlist.pages}页，共${actlist.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/comm/actlist?pn=1&ActName=${ActName}&OrgName=${OrgName}&StuName=${StuName}">首页</a> </li>
                    <c:if test="${actlist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/comm/actlist?pn=${actlist.pageNum-1}&ActName=${ActName}&OrgName=${OrgName}&StuName=${StuName}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${actlist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/comm/actlist?pn=${page}&ActName=${ActName}&OrgName=${OrgName}&StuName=${StuName}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${actlist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/comm/actlist?pn=${actlist.pageNum+1}&ActName=${ActName}&OrgName=${OrgName}&StuName=${StuName}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/comm/actlist?pn=${actlist.pages}&ActName=${ActName}&OrgName=${OrgName}&StuName=${StuName}">末页</a> </li>

                </ul>
            </nav>
        </div>
    </div>
</div>



<%--查看详情模态框--%>
<div class="modal fade" id="actinfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">活动信息</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-6">活动名字</label>
                                    <label class="col-md-6">活动编号</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control form-control-line" id="act_name" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control form-control-line" id="act_id" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">负责人电话</label>
                                    <label class="col-md-6">负责人姓名</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="manager_phone" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="manager_name" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">负责人班级</label>
                                    <label class="col-md-6">活动地点</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="manager_clasroom" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="act_place" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">活动简介</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="act_info" style="height: 150px" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">活动开始时间</label>
                                    <label class="col-md-6">活动结束时间</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="start_time" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="end_time" readonly>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="joinact($('#act_id').val())">申请加入该活动</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
