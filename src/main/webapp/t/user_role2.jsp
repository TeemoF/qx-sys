<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户角色分配</title>
<jsp:include page="../common.jsp"></jsp:include>
<script>
so.init(function(){
		//初始化全选。
		so.checkBoxInit('#checkAll','[check=box]');
		
		//全选
		so.id('deleteAll').on('click',function(){
			var checkeds = $('[check=box]:checked');
			if(!checkeds.length){
				return layer.msg('请选择要清除的用户。',so.default),!0;
			}
			var array = [];
			checkeds.each(function(){
				array.push(this.value);
			});
			return deleteById(array);
		});
		
	});
	
	
	function deleteById(ids){
		var index = layer.confirm("确定清除这"+ ids.length +"个用户的角色？",function(){
			var load = layer.load();
			$.post('http://shiro.itboy.net:80/role/clearRoleByUserIds.shtml',{userIds:ids.join(',')},function(result){
				layer.close(load);
				if(result && result.status != 200){
					return layer.msg(result.message,so.default),!0;
				}else{
					layer.msg(result.message);
					setTimeout(function(){
						$('#formId').submit();
					},1000);
				}
			},'json');
			layer.close(index);
		});
	}
	
	
	
	function selectRole(){
		var checked = $("#boxRoleForm  :checked");
		var ids=[],names=[];
		$.each(checked,function(){
			ids.push(this.id);
			names.push($.trim($(this).attr('name')));
		});
		var index = layer.confirm("确定操作？",function(){
			
			var load = layer.load();
			$.post('http://shiro.itboy.net:80/role/addRole2User.shtml',{ids:ids.join(','),userId:$('#selectUserId').val()},function(result){
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
	function selectRoleById(id){
		var load = layer.load();
		$.post("http://shiro.itboy.net:80/role/selectRoleByUserId.shtml",{id:id},function(result){
			layer.close(load);
			if(result && result.length){
				var html =[];
				$.each(result,function(){
					html.push("<div class='checkbox'><label>");
					html.push("<input type='checkbox' id='");
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
				return so.id('boxRoleForm').html(html.join('')) & $('#selectRole').modal(),$('#selectUserId').val(id),!1;
			}else{
				return layer.msg(result.message,so.default);
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
				<h2>用户角色分配</h2>
				<hr>
				<form method="post" action="" id="formId" class="form-inline">
					<div clss="well">
				      <div class="form-group">
				        <input type="text" class="form-control" style="width: 300px;" value="" name="findContent" id="findContent" placeholder="输入用户昵称 / 用户帐号">
				      </div>
				     <span class=""> 
			         	<button type="submit" class="btn btn-primary">查询</button>
			         		<button type="button" id="deleteAll" class="btn  btn-danger">清空用户角色</button>
			         </span>    
			        </div>
			        <hr>
					<table class="table table-bordered">
						<input type="hidden" id="selectUserId">
						<tbody><tr>
							<th width="5%"><input type="checkbox" id="checkAll"></th>
							<th width="10%">用户昵称</th>
							<th width="10%">Email/帐号</th>
							<th width="10%">状态</th>
							<th width="55%">拥有的角色</th>
							<th width="10%">操作</th>
						</tr>
						<tr>
							<td><input value="1" check="box" type="checkbox"></td>
							<td>管理员</td>
							<td>admin</td>
							<td>有效</td>
							<td roleids="1">系统管理员</td>
							<td>
									<i class="glyphicon glyphicon-share-alt"></i><a href="javascript:selectRoleById(1);">选择角色</a>
							</td>
						</tr>
					
						<tr>
							<td><input value="11" check="box" type="checkbox"></td>
							<td>soso</td>
							<td>8446666@qq.com</td>
							<td>有效</td>
							<td roleids="3,4">权限角色,用户中心</td>
							<td>
									<i class="glyphicon glyphicon-share-alt"></i><a href="javascript:selectRoleById(11);">选择角色</a>
							</td>
						</tr>
					
						<tr>
							<td><input value="12" check="box" type="checkbox"></td>
							<td>8446666</td>
							<td>8446666</td>
							<td>有效</td>
							<td roleids="4">用户中心</td>
							<td>
									<i class="glyphicon glyphicon-share-alt"></i><a href="javascript:selectRoleById(12);">选择角色</a>
							</td>
						</tr>
					</tbody>
				</table>
					
				<div class="pagination pull-right">
					<ul class="pagination"><li class="active"><a href="javascript:void(0);">1</a></li></ul><script>	function _submitform(pageNo){		$("#formId").append($("<input type='hidden' value='" + pageNo +"' name='pageNo'>")).submit();	}</script>
				</div>
			</form>
		</div>
	</div>
			
			
	<div class="modal fade bs-example-modal-sm" id="selectRole" tabindex="-1" role="dialog" aria-labelledby="selectRoleLabel">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title" id="selectRoleLabel">添加角色</h4>
	      </div>
	      <div class="modal-body">
	        <form id="boxRoleForm">
	          loading...
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" onclick="selectRole();" class="btn btn-primary">Save</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</div>

</body>
</html>