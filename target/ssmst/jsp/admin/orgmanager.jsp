<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/18
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>社团管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        function showorgs(num) {
            $.ajax({
                type:"GET",
                data:{num:num},
                url:"/comm/showMa",
                success:function (msg) {
                    if (msg){

                        //将后端传出的数据进行存储放入模态框中
                        $("#org_name").val(msg.org.name);
                        $("#manager_num").val(msg.manager.num);
                        $("#manager_name").val(msg.manager.name);
                        $("#manager_clasroom").val(msg.manager.classroom);
                        $("#org_info").val(msg.org.info);
                        $("#org_stu_num").val(msg.count);
                        $("#org_id").val(msg.org.id);


                        $("#orginfo").modal("show");
                    }else {
                        alert("操作失败，请稍后再试！")
                    }
                }
            })
        }
        function delorg(org_id) {
            //通过社团id删除社团。
            var r = confirm("确认解散该社团吗？解散后所有关于该社团的活动和通知都将删除！");
            if (r){
                $.ajax({
                    type:"DELETE",
                    data:{orgid:org_id},
                    url:"/org/deleorg",
                    success:function (msg) {
                        if (msg){
                            alert("删除成功！");
                            window.location.href="/admin/orgman";
                        }else {
                            alert("操作失败，请稍后再试！");
                            window.location.href="/admin/orgman";
                        }
                    }
                })
            }else {
                window.location.href="/admin/orgman";
            }
        }
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">社团列表</h1>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">

            <div class="col-md-12 input-group input-group-lg">
                <form action="/admin/orgman">
                    <input class="text form-control" placeholder="请输入社团名字" id="Orgname1" name="Orgname1" style="width: 350px" value="${Orgname1}">
                    <input class="text form-control" placeholder="请输入社团负责人" id="orgmana1" name="orgmana1" style="width: 350px;margin-left: 15px" value="${orgmana1}">
                    <button class="btn btn-info" role="group" <%--onclick="findorg($('#findorgname').val(),$('#stu_name').val())"--%>
                            type="submit"
                    >查询</button>
                </form>

            </div>

            <table class="table table-hover">
                <thead>
                <tr>
                    <td>社团编号</td>
                    <td>社团名称</td>
                    <td>社团负责人</td>
                    <td>社团状态</td>
                    <td>创建社团时间</td>
                    <td>操作</td>
                </tr>
                </thead>
                <c:forEach items="${orglist.list}" var="org">
                    <tr>
                        <td>${org.id}</td>
                        <td>${org.name}</td>
                        <td>${org.manager.name}</td>
                        <td>${org.statu==1?"正常":"审核中"}</td>
                        <td>${org.create_time}</td>
                        <td><button type="button" class="btn btn-primary" onclick="showorgs(${org.managernum})" >
                            查看详情
                        </button>
                            <a type="button" class="btn btn-info" href="/admin/showstus?org_id=${org.id}"  <c:if test="${org.statu==0}">disabled</c:if>>社团成员</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${orglist.pageNum}页，总共${orglist.pages}页，共${orglist.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/admin/orgman?pn=1&Orgname1=${Orgname1}&orgmana1=${orgmana1}">首页</a> </li>
                    <c:if test="${orglist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/orgman?pn=${orglist.pageNum-1}&Orgname1=${Orgname1}&orgmana1=${orgmana1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${orglist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/admin/orgman?pn=${page}&Orgname1=${Orgname1}&orgmana1=${orgmana1}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${orglist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/orgman?pn=${orglist.pageNum+1}&Orgname1=${Orgname1}&orgmana1=${orgmana1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/admin/orgman?pn=${orglist.pages}&Orgname1=${Orgname1}&orgmana1=${orgmana1}">末页</a> </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<%--社团详情模态框--%>
<div class="modal fade" id="orginfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">社团详情</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-12">社团名字</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="org_name" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">管理员学号</label>
                                    <label class="col-md-6">管理员姓名</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="manager_num" readonly>
                                    </div>
                                    <div class="col-md-6">
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
                                    <label class="col-md-12">社团简介</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="org_info" style="height: 150px" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">社团人数</label>
                                    <label class="col-md-6">社团编号</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="org_stu_num" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="org_id" readonly>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger"onclick="delorg($('#org_id').val())">解散该社团</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
