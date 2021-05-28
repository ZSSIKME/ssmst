<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/18
  Time: 20:33
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申请创建社团列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        /*点击按钮
* 弹出模态框显示社团信息，通过表单内的stunum查询出社长信息返回，在模态框中显示
* */
        function showorg(orgname,orginfo,stuname,stunum,orgid,stuclassroom,stuphone) {

            //alert(orgname+orginfo+stuname+stunum+orgid+stuclassroom+stuphone);
            $("#app_org_name").val(orgname);
            $("#app_manager_num").val(stunum);
            $("#app_manager_name").val(stuname);
            $("#app_manager_clasroom").val(stuclassroom);
            $("#app_org_id").val(orgid);
            $("#app_manager_phone").val(stuphone);
            $("#app_org_info").val(orginfo);

            $("#orginfo").modal("show");
        }

        function agreeorg(orgid,stunum) {
            //alert(orgid);
            $.ajax({
                type: "PUT",
                data: {orgid:orgid,stunum:stunum},
                url: "/admin/agreeorg",
                success:function (msg) {
                    if (msg){
                        alert("操作成功！该社团已成功申请！")
                        window.location.href="/admin/show_apply_org";
                    }else {
                        alert("操作失败，请稍后再试！")
                        window.location.href="/admin/show_apply_org";
                    }
                }
            })
        }

        //拒绝申请
        function reject(stunum,orgid) {
            //拒绝申请请求
            var b = confirm("是否确认拒绝该申请？");
            if (b){
                $.ajax({
                    type: "DELETE",
                    data: {orgid:orgid,stunum:stunum},
                    url: "/admin/rejectorg",
                    success:function (msg) {
                        if (msg){
                            alert("操作成功！已拒绝该社团申请！")
                            window.location.href="/admin/show_apply_org";
                        }else {
                            alert("操作失败，请稍后再试！")
                            window.location.href="/admin/show_apply_org";
                        }
                    }
                })
            }else {
                window.location.href="/admin/show_apply_org";
            }

        }
    </script>
</head>
<body style="background:transparent;">

<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">申请创建社团列表</h1>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <td>社团编号</td>
                    <td>社团名称</td>
                    <td>社团负责人</td>
                    <td>创建社团时间</td>
                    <td>社团状态</td>
                    <td>操作</td>
                </tr>
                </thead>
                <c:forEach items="${applyorgs.list}" var="org">
                    <tr>
                        <td>${org.stu_org}</td>
                        <td>${org.organization.name}</td>
                        <td>${org.student.name}</td>
                        <td>${org.organization.create_time}</td>
                        <td>${org.organization.statu==1?"正常":"请审核"}</td>
                        <td>
                            <button type="button" class="btn btn-primary" onclick="showorg('${org.organization.name}','${org.organization.info}',
                                    '${org.student.name}','${org.stu_num}','${org.stu_org}','${org.student.classroom}','${org.student.phone}')">
                            查看详情
                            </button>
                            <button type="button" class="btn btn-danger" onclick="reject('${org.stu_num}','${org.stu_org}')">
                                拒绝申请
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${applyorgs.pageNum}页，总共${applyorgs.pages}页，共${applyorgs.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/admin/show_apply_org?pn=1">首页</a> </li>
                    <c:if test="${applyorgs.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/show_apply_org?pn=${applyorgs.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${applyorgs.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/admin/show_apply_org?pn=${page}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${applyorgs.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/show_apply_org?pn=${applyorgs.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/admin/show_apply_org?pn=${applyorgs.pages}">末页</a> </li>

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
                                        <input type="text" class="form-control form-control-line" id="app_org_name" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">管理员学号</label>
                                    <label class="col-md-6">管理员姓名</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="app_manager_num" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="app_manager_name" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">管理员班级</label>
                                    <label class="col-md-6">社团编号</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="app_manager_clasroom" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="app_org_id" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">管理员电话</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="app_manager_phone" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">社团简介</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="app_org_info" style="height: 150px" readonly>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="agreeorg($('#app_org_id').val(),$('#app_manager_num').val())">同意该申请</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
