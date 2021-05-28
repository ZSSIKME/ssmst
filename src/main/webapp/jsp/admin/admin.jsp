<%--
  Created by IntelliJ IDEA.
  User: savior
  Date: 2021/4/2
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统管理员</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/metro.min.css" />
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <style>
        #header {
            height: 160px;
        }
        #bigtitle {
            font-family: "隶书";
            letter-spacing: 10px;
            padding: 20px;
            display: block;
            margin: 0px auto;
            text-align: center;
            font-size: 90px;
            font-weight: bold;
            color: white;
            text-shadow: 3px 3px 5px #262626;
        }
        #div-bgimg {
            width: 100%;
            height: 150%;
            z-index: -1;
            position: absolute;
            left: 0px;
        }

        #bgimg {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div id="div-bgimg">
        <img src="${pageContext.request.contextPath }/static/img/indexbg.jpg"
             id="bgimg" />
    </div>
    <div class="row">

        <div class="col-md-12" id="header">
            <span id="bigtitle"> 社团管理系统 </span>
        </div>
        <div class="col-md-2 col-md-offset-10">
            <span><img src="${pageContext.request.contextPath }/static/img/user.jpg" class="img-circle"></span>
            <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">我的</button>
            <ul class="dropdown-menu">
                <li><a href="/out">退出登录</a></li>
            </ul>
        </div>
    </div>


    <div class="row">
        <div class="col-md-1">
        </div>
        <div class="col-md-2">
            <iframe src="${pageContext.request.contextPath }/jsp/admin/left.jsp" height="1000px" width="100%" frameborder="no" allowtransparency="true"></iframe>
        </div>
        <div class="col-md-8" >
            <iframe id="main" name="main" scrolling="No" noresize="noresize" title="main" height="1000px" width="100%" aria-hidden="false" allowtransparency="true">

            </iframe>
        </div>
        <div class="col-md-1">
        </div>
    </div>
</div>
</body>
</html>
