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
    <title>我的活动</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
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

        function signinact(actid) {
            $.ajax({
                type: "PUT",
                data: {actid:actid},
                url: "/comm/signinact",
                success:function (msg) {
                    if (msg){
                        alert("签到成功！")
                        window.location.href="/comm/myact";
                    }else {
                        alert("你已经签到过了，不要重复操作哦！")
                        window.location.href="/comm/myact";
                    }
                }
            })
        }
        /*
        * 取消加入该活动
        * */
        function cancelact(act_id) {
            $.ajax({
                type: "DELETE",
                data: {actid:act_id},
                url: "/comm/cancelact",
                success:function (msg) {
                    if (msg){
                        alert("取消成功！")
                        window.location.href="/comm/myact";
                    }else {
                        alert("取消失败，请稍后再试试吧！")
                    }
                }
            })
        }
        
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">我参加的活动</h1>
<div class="col-md-12">
    <div class="col-md-12 input-group input-group-lg">
        <form action="/comm/myact">
            <input class="text form-control" placeholder="请输入活动名字" id="actname1" name="actname1" style="width: 450px" value="${actname1}">
            <button class="btn btn-info" role="group" type="submit">查询</button>
        </form>
    </div>

</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-condensed table-bordered table-striped" style="table-layout:fixed">
                <thead>
                <tr>
                    <td>活动编号</td>
                    <td>活动名称</td>
                    <td>活动简介</td>
                    <td>活动负责人</td>
                    <td>活动地点</td>
                    <td>操作</td>
                </tr>
                </thead>

                <c:forEach items="${myactlist.list}" var="stu_act">
                    <tr>
                        <td id="actid">${stu_act.act_id}</td>
                        <td>${stu_act.activity.name}</td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${stu_act.activity.info}</td>
                        <td>${stu_act.student.name}</td>
                        <td>${stu_act.activity.place}</td>
                        <td><button class="btn-primary" onclick="showactinfo('${stu_act.act_id}')">查看详情</button>
                            <button class="btn-danger" onclick="cancelact('${stu_act.act_id}')">退出</button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty myactlist.list}">
                    <div>
                        <h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #9b9b9b">你还未参加活动</h1>
                    </div>
                </c:if>
            </table>
        </div>
    </div>

    <%--分页--%>
    <div class="row">
        <div class="col-md-6">
            当前第${myactlist.pageNum}页，总共${myactlist.pages}页，共${myactlist.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/comm/myact?pn=1&actname1=${actname1}">首页</a> </li>
                    <c:if test="${myactlist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/comm/myact?pn=${myactlist.pageNum-1}&actname1=${actname1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${myactlist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/comm/myact?pn=${page}&actname1=${actname1}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${myactlist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/comm/myact?pn=${myactlist.pageNum+1}&actname1=${actname1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/comm/myact?pn=${myactlist.pages}&actname1=${actname1}">末页</a> </li>

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
                <button type="button" class="btn btn-primary" onclick="signinact($('#act_id').val())">签到</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
