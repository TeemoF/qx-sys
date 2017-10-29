<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	.formdiv{
		width:500px;
		height:400px;
		border:1px solid #red;
		margin:0px auto;
	}
	body{
		width:900px;
		margin:200px auto;
	}
</style>
</head>
<body>
<div>
	<div class="formdiv">
		<form class="form-horizontal " role="form" action="${basePath}/login" method="post">
		  <div class="form-group has-error">
		    <label for="firstname" class="col-sm-2 control-label">用户名</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="username" value="admin" name="username" placeholder="请输入名字">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="lastname" class="col-sm-2 control-label">密码</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="password" value="admin"name="password" placeholder="请输入密码">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="lastname" class="col-sm-2 control-label">验证码</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="password" name="vcode" placeholder="请输入验证码">
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="lastname" class="col-sm-2 control-label"></label>
		    <div class="col-sm-10">
		        <img id="img" src="${basePath}/image" onclick="this.src='${basePath}/image?'+new Date().getTime()"/>
       			<a href='javascript:void(0);' onclick="javascript:document.getElementById('img').src = '${basePath}/image?date=' + new Date()">看不清？换一张 </a>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="remeber">请记住我
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button type="submit" class="btn btn-default">登录</button>
		    </div>
		  </div>
		</form>
	</div>
</div>
</body>
</html>