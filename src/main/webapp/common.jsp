<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
<c:set var="basePath" scope="request">${pageContext.request.contextPath}</c:set>
 

<link href="${basePath}/css/common/mybase.css" > 
<link rel="stylesheet" href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css" re>
<link rel="stylesheet" href="${basePath}/js/common/layer/skin/layer.css">
<link rel="stylesheet" type="text/css" href="${basePath}/js/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${basePath}/js/common/jquery-easyui/themes/icon.css">

<script src="${basePath}/js/common/jquery/jquery-1.11.1.js"></script>
<script src="${basePath}/js/common/layer/layer.js"></script>
<script src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="${basePath}/js/common/jquery-easyui/jquery.easyui.min.js"></script>

<script src="${basePath}/js/myutil.js"></script>
<script src="${basePath}/js/shiro.demo.js"></script>
<script src="${basePath}/js/user.login.js"></script>