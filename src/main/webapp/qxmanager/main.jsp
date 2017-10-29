<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main</title>
<jsp:include page="../common.jsp"></jsp:include>
<style type="text/css">
	body{
	width:1200px;
	margin:50px auto;
}


</style>
<script type="text/javascript">
$(function(){
	$("#menutitle>li").each(function(){
		$(this).click(function(){
			$(this).siblings().removeClass("active");
			$(this).addClass("active");
			var pageName = $(this).children('a').eq(0).attr("name");
			$("#content").attr("src",pageName);
		});
	});
	
});
</script>
</head>
<body style="border:1px solid red;">
	<%-- <jsp:include page="header.jsp"></jsp:include> --%>
	<ul class="nav nav-tabs nav-justified" id="menutitle">
		<shiro:hasAnyRoles name="权限列表管理员,系统管理员,普通用户">
	 		<li class="active"><a href="javascript:void(0);" name="perlist.jsp">权限列表</a></li>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="角色权限分配管理员,系统管理员,普通用户">
			<li><a href="javascript:void(0);" name="role_per.jsp">角色权限分配</a></li>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="角色列表管理员,系统管理员,普通用户">
			<li><a href="javascript:void(0);" name="rolelist.jsp">角色列表</a></li>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="用户角色分配管理员,系统管理员,普通用户">
			<li><a href="javascript:void(0);" name="user_role.jsp">用户角色分配</a></li>
		</shiro:hasAnyRoles>
	</ul>
	 <div  style="height:550px;width:100%;">
        <iframe id="content" src="perlist.jsp" width="100%" height="100%" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
    </div>
</body>
</html>