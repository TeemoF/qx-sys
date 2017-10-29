<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>权限分配</title>
<jsp:include page="../common.jsp"></jsp:include>
<script>
			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
			});
			function selectPermission(){
				var checked = $("#boxRoleForm  :checked");
				var ids=[],names=[];
				$.each(checked,function(){
					ids.push(this.id);
					names.push($.trim($(this).attr('name')));
				});
				var index = layer.confirm("确定操作？",function(){
					var load = layer.load();
					$.post('/permission/addPermission2Role.shtml',{ids:ids.join(','),roleId:$('#selectRoleId').val()},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!1;
						}
						layer.msg('添加成功。');
						setTimeout(function(){
							$('#formId').submit();
						},1000);
					},'json');
				});
			}
			/*
			*根据角色ID选择权限，分配权限操作。
			*/
			function selectPermissionById(id){
				var load = layer.load();
				$.post("/permission/selectPermissionById.shtml",{id:id},function(result){
					layer.close(load);
					if(result && result.length){
						var html =[];
						html.push('<div class="checkbox"><label><input type="checkbox"  selectAllBox="">全选</label></div>');
						$.each(result,function(){
							html.push("<div class='checkbox'><label>");
							html.push("<input type='checkbox' selectBox='' id='");
							html.push(this.id);
							html.push("'");
							if(this.check){
								html.push(" checked='checked'");
							}
							html.push("name='");
							html.push(this.name);
							html.push("'/>");
							html.push(this.name);
							html.push('</label></div>');
						});
						//初始化全选。
						return so.id('boxRoleForm').html(html.join('')),
						so.checkBoxInit('[selectAllBox]','[selectBox]'),
						$('#selectPermission').modal(),$('#selectRoleId').val(id),!1;
					}else{
						return layer.msg('没有获取到权限数据，请先添加权限数据。',so.default);
					}
				},'json');
			}
		</script>
</head>
<body data-target="#one" data-spy="scroll">
<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
	<div class="row">
		<jsp:include page="menu.jsp"></jsp:include>
	  
		<div class="col-md-10">
			<h2>权限分配</h2>
			<hr>
			<form method="post" action="" id="formId" class="form-inline">
				<div clss="well">
			      <div class="form-group">
			        <input type="text" class="form-control" style="width: 300px;" value="" name="findContent" id="findContent" placeholder="输入角色名称 / 角色类型">
			      </div>
			     <span class=""> 
		         	<button type="submit" class="btn btn-primary">查询</button>
		         </span>    
		        </div>
			<hr>
			<table class="table table-bordered">
				<input type="hidden" id="selectRoleId">
				<tbody><tr>
					<th width="5%"><input type="checkbox" id="checkAll"></th>
					<th width="10%">角色名称</th>
					<th width="10%">角色类型</th>
					<th width="60%">拥有的权限</th>
					<th width="15%">操作</th>
				</tr>
						<tr>
							<td><input value="1" check="box" type="checkbox"></td>
							<td>系统管理员</td>
							<td>888888</td>
							<td permissionids="7,10,13,16,19,4,8,11,14,17,20,6,9,12,15,18">权限删除,用户Session踢出,权限分配,角色列表删除,权限分配,权限列表,用户列表,用户激活&amp;禁止,用户角色分配清空,角色列表添加,角色分配,权限添加,在线用户,用户删除,角色分配保存,角色列表</td>
							<td>
									<i class="glyphicon glyphicon-share-alt"></i><a href="javascript:selectPermissionById(1);">选择权限</a>
							</td>
						</tr>
						<tr>
							<td><input value="3" check="box" type="checkbox"></td>
							<td>权限角色</td>
							<td>100003</td>
							<td permissionids="6,14,17,20,7,15,18,4,13,16,19">权限添加,用户角色分配清空,角色列表添加,角色分配,权限删除,角色分配保存,角色列表,权限列表,权限分配,角色列表删除,权限分配</td>
							<td>
									<i class="glyphicon glyphicon-share-alt"></i><a href="javascript:selectPermissionById(3);">选择权限</a>
							</td>
						</tr>
						<tr>
							<td><input value="4" check="box" type="checkbox"></td>
							<td>用户中心hahahaah </td>
							<td>100002</td>
							<td permissionids="8,11,9,12,10">用户列表,用户激活&amp;禁止,在线用户,用户删除,用户Session踢出</td>
							<td>
									<i class="glyphicon glyphicon-share-alt"></i><a href="javascript:selectPermissionById(4);">选择权限</a>
							</td>
						</tr>
			</tbody></table>
			<div class="pagination pull-right">
				<ul class="pagination"><li class="active"><a href="javascript:void(0);">1</a></li></ul><script>	function _submitform(pageNo){		$("#formId").append($("<input type='hidden' value='" + pageNo +"' name='pageNo'>")).submit();	}</script>
			</div>
		</form>
	</div>
	</div>			
	<div class="modal fade bs-example-modal-sm" id="selectPermission" tabindex="-1" role="dialog" aria-labelledby="selectPermissionLabel">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title" id="selectPermissionLabel">添加权限</h4>
	      </div>
	      <div class="modal-body">
	        <form id="boxRoleForm">
	          loading...
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" onclick="selectPermission();" class="btn btn-primary">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
			
	
</body>
</html>