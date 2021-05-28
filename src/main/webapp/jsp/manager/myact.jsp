<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/17
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>发布活动</title>
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

        function creact(name,place,info,act_time,act_end_time) {
            if (name==''||place==''||info==''||act_time==''||act_end_time==''){
                $("#warn").html("不能填入空值");
            }else {
                $.ajax({
                    url: "/act/createact",
                    type: "POST",
                    data: {name:name,place:place,info:info,act_time:act_time,act_end_time:act_end_time},
                    success: function (msg) {
                        if (msg) {
                            alert("创建活动成功！");
                            window.location.href="/act/myact";
                        }else {
                            alert("创建活动失败，请稍后再试！");
                            window.location.href="/act/myact";
                        }
                    }
                })
            }
        }

        function alteract(actid,name,place,info,act_time,act_end_time) {
            //修改活动信息
            $.ajax({
                url: "/act/alteract",
                type: "PUT",
                data: {id:actid,name:name,place:place,info:info,act_time:act_time,act_end_time:act_end_time},
                success: function (msg) {
                    if (msg) {
                        alert("修改成功！");
                        window.location.href="/act/myact";
                    }else {
                        alert("修改活动失败，请稍后再试！");
                        window.location.href="/act/myact";
                    }
                }
            })
        }
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">我创建的活动</h1>


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
                    <td>操作
                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#creatact">
                            创建活动
                        </button>
                    </td>
                </tr>
                </thead>

                <c:forEach items="${myactlist.list}" var="act">
                    <tr>
                        <td id="actid">${act.id}</td>
                        <td>${act.name}</td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${act.info}</td>
                        <td>${stu.name}</td>
                        <td>${act.place}</td>
                        <td>
                            <button class="btn-primary" onclick="showactinfo('${act.id}')">详情</button>
                            <button class="btn-primary" onclick="window.location.href='/act/stulist?act_id=${act.id}'">参加学生</button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty myactlist.list}">
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
            当前第${myactlist.pageNum}页，总共${myactlist.pages}页，共${myactlist.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/act/myact?pn=1">首页</a> </li>
                    <c:if test="${myactlist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/act/myact?pn=${myactlist.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${myactlist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/act/myact?pn=${page}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${myactlist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/act/myact?pn=${myactlist.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/act/myact?pn=${myactlist.pages}">末页</a> </li>

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
                                        <input type="text" class="form-control form-control-line" id="act_name">
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
                                        <input type="test" class="form-control form-control-line" id="act_place">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">活动简介</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="act_info" style="height: 150px">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">活动开始时间</label>
                                    <label class="col-md-6">活动结束时间</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="start_time">
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="end_time">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="alteract($('#act_id').val(),$('#act_name').val(),$('#act_place').val(),$('#act_info').val(),$('#start_time').val(),$('#start_time').val(),)">修改</button>
            </div>
        </div>
    </div>
</div>


<%--创建活动模态框--%>
<div class="modal fade" id="creatact" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">创建活动</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-6">活动名字</label>
                                    <label class="col-md-6">活动地点</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control form-control-line" id="cre_act_name">
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="cre_act_place">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">活动简介</label>
                                    <div class="col-md-12">
                                       <%-- <input type="test" class="form-control form-control-line" id="cre_act_info" style="height: 150px" >--%>
                                        <textarea id="cre_act_info" rows="20px" cols="60px"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">活动开始时间</label>
                                    <label class="col-md-6">活动结束时间</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="cre_start_time">
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="cre_end_time">
                                    </div>
                                </div>
                                <div class="warning col-md-offset-4">
                                    <span id="warn" style="color: #ff0000;text-align: center"></span>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="creact($('#cre_act_name').val(),$('#cre_act_place').val(),$('#cre_act_info').val(),$('#cre_start_time').val(),$('#cre_end_time').val(),)">创建</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
