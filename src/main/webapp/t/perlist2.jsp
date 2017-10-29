<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>权限列表</title>
<jsp:include page="../common.jsp"></jsp:include>
<script>
so.init(function(){
	//初始化全选。
	so.checkBoxInit('#checkAll','[check=box]');
	//全选
	so.id('deleteAll').on('click',function(){
		var checkeds = $('[check=box]:checked');
		if(!checkeds.length){
			return layer.msg('请选择要删除的选项。',so.default),!0;
		}
		var array = [];
		checkeds.each(function(){
			array.push(this.value);
		});
		return deleteById(array);
	});
});
function deleteById(ids){
	var index = layer.confirm("确定这"+ ids.length +"个权限？",function(){
		var load = layer.load();
		$.post('/permission/deletePermissionById.shtml',{ids:ids.join(',')},function(result){
			layer.close(load);
			if(result && result.status != 200){
				return layer.msg(result.message,so.default),!0;
			}else{
				layer.msg(result.resultMsg);
				setTimeout(function(){
					$('#formId').submit();
				},1000);
			}
		},'json');
		layer.close(index);
	});
}
function addPermission(){
	var name = $('#name').val(),
		url  = $('#url').val();
	if($.trim(name) == ''){
		return layer.msg('权限名称不能为空。',so.default),!1;
	}
	if($.trim(url) == ''){
		return layer.msg('权限Url不能为空。',so.default),!1;
	}
	var load = layer.load();
	$.post('/permission/addPermission.shtml',{name:name,url:url},function(result){
		layer.close(load);
		if(result && result.status != 200){
			return layer.msg(result.message,so.default),!1;
		}
		layer.msg('添加成功。');
		setTimeout(function(){
			$('#formId').submit();
		},1000);
	},'json');
}
</script>

</head>
<body data-target="#one" data-spy="scroll">
<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
	<div class="row">
		<jsp:include page="menu.jsp"></jsp:include>
		
		<div class="col-md-10">
			<h2>权限列表</h2>
			<hr>
			<form method="post" action="" id="formId" class="form-inline">
				<div clss="well">
			      <div class="form-group">
			        <input type="text" class="form-control" style="width: 300px;" value="" name="findContent" id="findContent" placeholder="输入权限名称">
			      </div>
			     <span class=""> 
		         	<button type="submit" class="btn btn-primary">查询</button>
		         		<a class="btn btn-success" onclick="$('#addPermission').modal();">增加权限</a>
		         		<button type="button" id="deleteAll" class="btn  btn-danger">Delete</button>
		         </span>    
		        </div>
			<hr>
			<table class="table table-bordered">
				<tbody>
				<tr>
					<th><input type="checkbox" id="checkAll"></th>
					<th>权限名称</th>
					<th>角色类型</th>
					<th>操作</th>
				</tr>
				<tr>
					<td><input value="4" check="box" type="checkbox"></td>
					<td>权限列表</td>
					<td>/permission/index.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([4]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="6" check="box" type="checkbox"></td>
					<td>权限添加</td>
					<td>/permission/addPermission.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([6]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="7" check="box" type="checkbox"></td>
					<td>权限删除</td>
					<td>/permission/deletePermissionById.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([7]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="8" check="box" type="checkbox"></td>
					<td>用户列表</td>
					<td>/member/list.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([8]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="9" check="box" type="checkbox"></td>
					<td>在线用户</td>
					<td>/member/online.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([9]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="10" check="box" type="checkbox"></td>
					<td>用户Session踢出</td>
					<td>/member/changeSessionStatus.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([10]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="11" check="box" type="checkbox"></td>
					<td>用户激活&amp;禁止</td>
					<td>/member/forbidUserById.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([11]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="12" check="box" type="checkbox"></td>
					<td>用户删除</td>
					<td>/member/deleteUserById.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([12]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="13" check="box" type="checkbox"></td>
					<td>权限分配</td>
					<td>/permission/addPermission2Role.shtml</td>
					<td>
							<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([13]);">删除</a>
					</td>
				</tr>
				<tr>
					<td><input value="14" check="box" type="checkbox"></td>
					<td>用户角色分配清空</td>
					<td>/role/clearRoleByUserIds.shtml</td>
					<td>
						<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([14]);">删除</a>
					</td>
				</tr>
			</tbody>
		</table>
			<div class="pagination pull-right">
				<ul class="pagination"><li class="active"><a href="javascript:void(0);">1</a></li><li><a href="javascript:;" onclick="_submitform(2)">2</a></li><li><a href="javascript:;" onclick="_submitform(2)">下一页</a></li></ul><script>	function _submitform(pageNo){		$("#formId").append($("<input type='hidden' value='" + pageNo +"' name='pageNo'>")).submit();	}</script>
			</div>
		</form>
	</div>
	</div>
	<div class="modal fade" id="addPermission" tabindex="-1" role="dialog" aria-labelledby="addPermissionLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title" id="addPermissionLabel">添加权限</h4>
	      </div>
	      <div class="modal-body">
	        <form id="boxRoleForm">
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">权限名称:</label>
	            <input type="text" class="form-control" name="name" id="name" placeholder="请输入权限名称">
	          </div>
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">权限URL地址:</label>
	            <input type="text" class="form-control" id="url" name="url" placeholder="请输入权限URL地址">
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" onclick="addPermission();" class="btn btn-primary">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
			
	
</body>
</html>