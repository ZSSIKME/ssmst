<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/18
  Time: 0:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发布的通知</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        function editor(newsid,detail) {
            $("#newsid").val(newsid);
            $("#newsDetail").val(detail);
            $("#editornews").modal("show");
        }

        function savenews(id,detail) {
            //编辑完成（通知）
            $.ajax({
                type:"PUT",
                url:"/news/editornews",
                data: {id:id,detail:detail},
                success:function (msg) {
                    if (msg){
                        alert("修改成功");
                        window.location.href="/news/myNews"
                    }else {
                        alert("修改失败，请稍后再试！")
                        window.location.href="/news/myNews"
                    }
                }
            })
        }

        function delnews(id) {
            //删除该记录
            var b = confirm("是否删除该通知？");
            if (b){
                $.ajax({
                    type:"DELETE",
                    url:"/news/delnews",
                    data: {id:id},
                    success:function (msg) {
                        if (msg){
                            alert("删除成功");
                            window.location.href="/news/myNews"
                        }else {
                            alert("删除失败，请稍后再试！")
                            window.location.href="/news/myNews"
                        }
                    }
                })
            }else {
                window.location.href="/news/myNews";
            }

        }

        function createnews(detail) {
            $.ajax({
                type:"POST",
                url:"/news/createnews",
                data: {detail:detail},
                success:function (msg) {
                    if (msg){
                        alert("创建成功");
                        window.location.href="/news/myNews"
                    }else {
                        alert("创建失败，请稍后再试！")
                        window.location.href="/news/myNews"
                    }
                }
            })
        }
    </script>
</head>
<body style="background:transparent;">

<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">通知列表</h1>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-condensed table-bordered table-striped" style="table-layout:fixed">
                <thead>
                <tr>
                    <td>编号</td>
                    <td>详情</td>
                    <td>发布时间</td>
                    <td>操作
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createnews">
                            发布新通知
                        </button>
                    </td>
                </tr>
                </thead>
                <c:forEach items="${newslist.list}" var="news">
                    <tr>
                        <td>${news.id}</td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${news.detail}</td>
                        <td>${news.newstime}</td>
                        <td><button type="button" class="btn btn-primary" onclick="editor('${news.id}','${news.detail}')">
                            编辑
                        </button>
                            <button type="button" class="btn btn-danger" onclick="delnews(${news.id})">
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${newslist.pageNum}页，总共${newslist.pages}页，共${newslist.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/news/myNews?pn=1">首页</a> </li>
                    <c:if test="${newslist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/news/myNews?pn=${newslist.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${newslist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/news/myNews?pn=${page}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${newslist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/news/myNews?pn=${newslist.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/news/myNews?pn=${newslist.pages}">末页</a> </li>

                </ul>
            </nav>
        </div>
    </div>
</div>


<%--模态框--%>
<div class="modal fade" id="editornews" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">通知信息</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <input type="text" class="hidden" id="newsid">
                    <label class="col-md-12">编辑通知信息</label>
                    <div class="col-md-12">
                        <%--<input type="test" class="form-control form-control-line" id="newsDetail1" style="height: 150px">--%>
                        <textarea id="newsDetail" rows="20px" cols="60px"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="savenews($('#newsid').val(),$('#newsDetail').val())">保存</button>
            </div>
        </div>
    </div>
</div>

<%--发布通知模态框--%>
<div class="modal fade" id="createnews" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">发布通知</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <label class="col-md-12">发布的通知信息</label>
                    <div class="col-md-12">
                        <%--<input type="test" class="form-control form-control-line" id="newsDetail1" style="height: 150px">--%>
                        <textarea id="createdetail" rows="20px" cols="60px"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="createnews($('#createdetail').val())">发布</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
