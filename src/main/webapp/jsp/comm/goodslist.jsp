<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/17
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>社团物品列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        function showgoods(id,name,number) {
            $("#name").val(name);
            $("#goods_id").val(id);
            $("#goods_num").val(number);
            $("#altergoods").modal("show");
        }


        function savegoods() {
            var goodsname=$("#name").val();
            var goodsid=$("#goods_id").val();
            var goodsnum=$("#goods_num").val();

            $.ajax({
                type:"PUT",
                url:"/goods/altergoods",
                data:{id:goodsid,name:goodsname,num:goodsnum},
                success:function (msg) {
                    if(msg){
                        //页面跳转到成功页面
                       alert("修改成功！")
                        window.location.href="/goods/showall";
                    }else{
                        //修改失败
                        alert("修改失败，请稍后再试");
                        window.location.href="/goods/showall";
                    }
                }
            })
        }

        function delgoods(goodsid) {
            $.ajax({
                type:"DELETE",
                url:"/goods/delgoods",
                data:{id:goodsid},
                success:function (msg) {
                    if(msg){
                        //页面跳转到成功页面
                        alert("删除成功！")
                        window.location.href="/goods/showall";
                    }else{
                        //修改失败
                        alert("删除失败，请稍后再试");
                        window.location.href="/goods/showall";
                    }
                }
            })
        }

        function isNumber(value) {         //验证是否为数字
            var patrn = /^(-)?\d+(\.\d+)?$/;
            if (patrn.exec(value) == null || value == "") {
                return false
            } else {
                return true
            }
        }
        function addgoods() {
            var name = $("#addgoodsname").val();
            var num = $("#addgoodsnum").val();
            if (name==''||num==''){
                $("#warn").html("不能填入空值");
            }else if (!isNumber(num)){
                $("#warn").html("数量请输入有效值！");
            }else {
                $.ajax({
                    type:"POST",
                    url:"/goods/addgoods",
                    data:{name:name,num:num},
                    success:function (msg) {
                        if(msg){
                            //页面跳转到成功页面
                            alert("添加成功！")
                            window.location.href="/goods/showall";
                        }else{
                            //修改失败
                            alert("添加失败，请稍后再试");
                            window.location.href="/goods/showall";
                        }
                    }
                })
            }

        }
    </script>
</head>
<body style="background:transparent;">
<h1 style="text-align: center;font-family: '微软雅黑', '宋体';color: #2e6da4">物品列表</h1>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">

            <div class="col-md-12 input-group input-group-lg">
                <form action="/goods/showall">
                    <input class="text form-control" placeholder="请输入物品名字" id="goods_name" name="goods_name" style="width: 450px" value="${goods_name}">
                    <button class="btn btn-info" role="group" <%--onclick="findorg($('#findorgname').val(),$('#stu_name').val())"--%>
                            type="submit"
                    >查询</button>
                </form>

            </div>

            <table class="table table-hover">
                <thead>
                <tr>
                    <td>物品编号</td>
                    <td>物品名字</td>
                    <td>物品数量</td>
                    <td>操作
                        <%--<button class="btn-primary" onclick="addgoods('${goodslist.list.get(0).organiza}')">添加物品</button>--%>
                        <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#addgoods">
                            添加物品
                        </button>
                    </td>
                </tr>
                </thead>
                <c:forEach items="${goodslist.list}" var="goods">
                    <tr>
                        <td>${goods.id}</td>
                        <td>${goods.name}</td>
                        <td>${goods.num}</td>
                        <td><button type="button" class="btn btn-primary" onclick="showgoods('${goods.id}','${goods.name}','${goods.num}')">
                            编辑物品信息
                        </button>
                            <button class="btn-danger" onclick="delgoods('${goods.id}')">删除物品</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${goodslist.pageNum}页，总共${goodslist.pages}页，共${goodslist.total}条记录。
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/goods/showall?pn=1&goods_name=${goods_name}">首页</a> </li>
                    <c:if test="${goodslist.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="/goods/showall?pn=${goodslist.pageNum-1}&goods_name=${goods_name}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${goodslist.navigatepageNums}" var="page">
                        <li class="page-item"><a class="page-link" href="/goods/showall?pn=${page}&goods_name=${goods_name}">${page}</a></li>
                    </c:forEach>
                    <c:if test="${goodslist.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="/goods/showall?pn=${goodslist.pageNum+1}&goods_name=${goods_name}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/goods/showall?pn=${goodslist.pages}&goods_name=${goods_name}">末页</a> </li>

                </ul>
            </nav>
        </div>
    </div>
</div>


<%--物品模态框--%>
<!-- Modal -->
<div class="modal fade" id="altergoods" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改物品信息</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-12">物品名字</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-6">物品编号</label>
                                    <label class="col-md-6">物品数量</label>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="goods_id" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="test" class="form-control form-control-line" id="goods_num">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="savegoods()">保存</button>
            </div>
        </div>
    </div>

</div>


<%--添加物品--%>
<div class="modal fade" id="addgoods" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">修改物品信息</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-block">
                            <form class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-12">物品名字</label>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control form-control-line" id="addgoodsname">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">物品数量</label>
                                    <div class="col-md-12">
                                        <input type="test" class="form-control form-control-line" id="addgoodsnum">
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
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addgoods()">添加</button>
            </div>
        </div>
    </div>

</div>
</body>
</html>
