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
    <title>我创建的社团</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        function createorg(orgname,orginfo) {
           /* alert(orgname);
            alert(orginfo);*/
            $.ajax({
                type:"POST",
                url:"/org/createorg",
                data:{orgname:orgname,orginfo:orginfo},
                success:function (msg) {
                    if (msg){
                        alert("创建成功,请等待管理员审核");
                        window.location.href="/comm/mycreateorg";
                    }else {
                        alert("创建失败，请稍后再试！");
                        window.location.href="/comm/mycreateorg";
                    }
                }
            })
        }

        function creorginfo(num) {
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


                        $("#createorginfo").modal("show");
                    }else {
                        alert("操作失败，请稍后再试！")
                    }
                }
            })
        }
        function delorg(orgid) {

            var r = confirm("确认取消该社团吗？");
            if (r){
                $.ajax({
                    type:"DELETE",
                    data:{orgid:orgid},
                    url:"/org/deleorg",
                    success:function (msg) {
                        if (msg){
                            alert("取消成功！")
                            window.parent.location.href="${pageContext.request.contextPath }/index.jsp";
                        }else {
                            alert("操作失败，请稍后再试！")
                            window.location.href="/comm/mycreateorg";
                        }
                    }
                })
            }else {
                window.location.href="/comm/mycreateorg";
            }

        }

        function alterOrgInfo(orgid,orgname,orginfo) {
            //修改社团信息
            $.ajax({
                url: "/org/alterorginfo",
                type: "PUT",
                data: {org_id:orgid,org_name:orgname,org_info:orginfo},
                success: function (msg) {
                    if (msg) {
                        alert("修改成功！");
                        window.location.href="/comm/mycreateorg";
                    }else {
                        alert("修改失败，请稍后再试！");
                        window.location.href="/comm/mycreateorg";
                    }
                }
            })
        }
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">我创建的社团</h1>
<table class="table table-hover table-condensed table-bordered table-striped" style="table-layout:fixed">
    <thead>
    <tr>
        <td>社团名称</td>
        <td>社团简介</td>
        <td>社团负责人</td>
        <td>社团状态</td>
        <td>操作</td>
    </tr>
    </thead>

        <tr>
            <td>${mycreOrg.name}</td>
            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${mycreOrg.info}</td>
            <td>${mycreOrg.managernum}</td>
            <td>${mycreOrg.statu==1?"正常":"审核中"}</td>
            <td>
                <button class="btn-primary" onclick="creorginfo('${mycreOrg.managernum}')">查看详情</button>
                <button class="btn-danger" onclick="delorg('${mycreOrg.id}')">取消创建</button>
            </td>
        </tr>
    <c:if test="${empty mycreOrg}">
        <div>
            <h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #9b9b9b">你暂时还没有创建的社团</h1>
            <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#creatorg">
                创建社团
            </button>
        </div>
    </c:if>
</table>

<!-- 创建社团Modal -->
<div class="modal fade" id="creatorg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">创建社团</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-12">社团名字</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="orgname">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">社团简介</label>
                                    <div class="col-md-12">
                                        <textarea rows="20px" cols="60px" id="orginfo"></textarea>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="createorg($('#orgname').val(),$('#orginfo').val())">提交申请</button>
            </div>
        </div>
    </div>
</div>

<%--查看创建社团详情--%>
<div class="modal fade" id="createorginfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">社团详情</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-12">社团名字</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="org_name">
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
                                        <textarea cols="70px" rows="20px" id="org_info"></textarea>
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
                                <div class="form-group">
                                    <h3 class="success">更多操作请等待系统管理员审核成功后使用管理员账号登录查看。</h3>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="alterOrgInfo($('#org_id').val(),$('#org_name').val(),$('#org_info').val())">修改</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
