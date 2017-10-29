<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="navbar navbar-inverse navbar-fixed-top animated fadeInDown" style="z-index: 101;height: 41px;">
	  
      <div class="container" style="padding-left: 0px; padding-right: 0px;">
        <div class="navbar-header">
          <button data-target=".navbar-collapse" data-toggle="collapse" type="button" class="navbar-toggle collapsed">
            <span class="sr-only">导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
	     </div>
	     <div role="navigation" class="navbar-collapse collapse">
	     		<a id="_logo" href="" style="color:#fff; font-size: 24px;" class="navbar-brand hidden-sm">SSM + Shiro Demo 演示</a>
	          <ul class="nav navbar-nav" id="topMenu">
				<li class="dropdown ">
					<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="http://shiro.itboy.net/user/index.shtml">
						个人中心<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="http://shiro.itboy.net/user/index.shtml">个人资料</a></li>
						<li><a href="http://shiro.itboy.net/user/updateSelf.shtml">资料修改</a></li>
						<li><a href="http://shiro.itboy.net/user/updatePswd.shtml">密码修改</a></li>
						<li><a href="http://shiro.itboy.net/role/mypermission.shtml">我的权限</a></li>
					</ul>
				</li>	  
				<li class="dropdown ">
					<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="http://shiro.itboy.net/member/list.shtml">
						用户中心<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
							<li><a href="http://shiro.itboy.net/member/list.shtml">用户列表</a></li>
							<li><a href="http://shiro.itboy.net/member/online.shtml">在线用户</a></li>
					</ul>
				</li>	
					<li class="dropdown active">
						<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="http://shiro.itboy.net/permission/index.shtml">
							权限管理<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
								<li><a href="./角色列表 - 权限管理_files/角色列表 - 权限管理.html">角色列表</a></li>
								<li><a href="http://shiro.itboy.net/role/allocation.shtml">角色分配（这是个JSP页面）</a></li>
								<li><a href="http://shiro.itboy.net/permission/index.shtml">权限列表</a></li>
								<li><a href="http://shiro.itboy.net/permission/allocation.shtml">权限分配</a></li>
						</ul>
					</li>	
				<li>
					<a class="dropdown-toggle" target="_blank" href="http://www.sojson.com/tag_shiro.html">
						Shiro相关博客<span class="collapsing"></span>
					</a>
				</li>	          
				<li>
					<a class="dropdown-toggle" href="http://www.sojson.com/shiro" target="_blank">
						本项目介绍<span class="collapsing"></span>
					</a>
				</li>	          
				<li>
					<a class="dropdown-toggle" href="http://www.sojson.com/jc/shiro.html" target="_blank">
						Shiro Demo 其他版本<span class="collapsing"></span>
					</a>
				</li>	          
	          </ul>
	           <ul class="nav navbar-nav  pull-right">
				<li class="dropdown " style="color:#fff;">
					<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" onclick="location.href=&#39;/user/index.shtml&#39;" href="http://shiro.itboy.net/user/index.shtml" class="dropdown-toggle qqlogin">
							管理员<span class="caret"></span></a>
							<ul class="dropdown-menu" userid="1">
								<li><a href="http://shiro.itboy.net/user/index.shtml">个人资料</a></li>
								<li><a href="http://shiro.itboy.net/role/mypermission.shtml">我的权限</a></li>
								<li><a href="javascript:void(0);" onclick="logout();">退出登录</a></li>
							</ul>
				</li>	
	          </ul>
	          <style>#topMenu>li>a{padding:10px 13px}</style>
	    </div>
  	</div>
</div>
</body>
</html>