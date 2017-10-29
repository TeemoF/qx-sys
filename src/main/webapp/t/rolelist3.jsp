<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色列表</title>
<jsp:include page="../common.jsp"></jsp:include>
<style type="text/css">
.datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber,
	.datagrid-cell-rownumber {
	margin: 0;
	padding: 0px 4px;
	white-space: nowrap;
	word-wrap: normal;
	overflow: hidden;
	height: 40px;
	line-height: 40px;
	font-size: 14px;
}

.datagrid-header-row, .datagrid-row {
	height: 40px;
}

.datagrid-header .datagrid-cell span {
	font-size: 18px;
	font-weight: bold;
}

/* //更改表格标题的行间距 */
.panel-title {
	margin: 0;
	height: 20px;
	line-height: 20px;
	font-size: 20px;
	color: inherit;
}

.datagrid-toolbar {
	height: auto;
	padding: 1px 2px;
	border-width: 0 0 1px 0;
	border-style: solid;
	margin: 10px;
	background-color: white;
}

.datagrid-header td, .datagrid-body td, .datagrid-footer td {
	border-width: 1px 1px 1px 0;
	border-style: dotted;
	margin: 0;
	padding: 0;
}
</style>
<script>
	$(function() {
		$("#dg").datagrid(
		{
			title : "用户信息表",
			rownumbers : true,
			striped : true,
			singleSelect : false,
			autoRowHeight : false,
			pagination : true,
			pageSize : 2,
			pageList : [ 2, 3, 5, 8, 10, 20, 30, 40 ],
			fitColumns : true,
			/* fit:true, */
			width : 1200,
			method : 'get',
			url : "${basePath}/rolelist",
			toolbar : "#toolbar",
			loadMsg : '数据加载中,请稍后...',
			columns : [ [
					{
						field : 'id',
						title : 'ID',
						align : 'center',
						width : 100,
						formatter : function(value, role, index) {
							return role.id;
						}
					},
					{
						field : 'name',
						title : '角色名称',
						align : 'center',
						width : 80,
						formatter : function(value, role, index) {
							return '<button type="button" onclick="detail('+index+')" class="btn btn-link">'+role.roleName+'</button>';
						}
					},
					{
						field : 'roleType',
						title : '角色类型',
						align : 'center',
						width : 100,
						formatter : function(value, role, index) {
							return role.roleType;
						}
					}
					] ],
			onLoadSuccess : function(s) {
				$(this).datagrid('getPanel').css({ //修改标题样式
					"font-size" : "13px",
					"color" : "#333333"
				});
				;
				$("tr:gt(1)").each(function(index, value) {
					if (index % 2 == 0) {
						$(this).css("background-color","#FFFFFF");
					} else {
						$(this).css("background-color","#FFFFF0");
					}
					var oldcolor = $(this).css(
							"background-color");
					$(this).hover(function() {
							$(this).css("background-color","#ADD8E6");
						},
						function() {
							$(this).css("background-color",oldcolor);
						});
				});
			}
		});
		var p = $('#dg').datagrid('getPager');
		var opts = $('#dg').datagrid('options');
		$(p).pagination({
			beforePageText : '第',//页数文本框前显示的汉字   
			afterPageText : '页    共 {pages} 页',
			displayMsg : '第{from}到{to}条，共{total}条',
			fit:true
		});

		//给收索框绑定事件，内容改变，自动触发收索功能
		$("input[name='findContent']").bind('input propertychange', function() {
			$('#dg').datagrid('load', {
				sn : $("input[name='findContent']").val()
			});
		});
		
		//清空保存按钮的绑定事件【保存按钮两个功能：1修改数据的保存 2新添加数据的保存 所以要区分】
		$("button[name='saveBtn']").unbind();
		//给保存按钮添加默认绑定数据保存功能事件
		$("button[name='saveBtn']").click(function(){
			//掉用添加角色方法
			addRole();
		});
		//添加按钮绑定时间
		$("button[name='addBtn']").click(function(){
			$("#addroleLabel").html("添加角色");
			$("button[name='editBtn']").css("display","none");
			$("button[name='delBtn']").css("display","none");
			//将表单重置
			$("#boxRoleForm")[0].reset();
			//显示弹框
			$('#addrole').modal();
		});
		//更改表格标题行颜色
		$($(".datagrid-header-row").children("td")).each(function(){
			$(this).css("background","#F0FFF0");
		});
	});
	
	//添加新的角色,点击保存的时候触发该方法【保存按钮默认绑定事件】
	function addRole() {
		var name = $('#name').val(), type = $('#type').val();
		var data = $("#boxRoleForm").serializeObject();
		if (!name || name == '') {
			return layer.msg('角色名称不能为空。');
		}
		if (!type || type == '') {
			return layer.msg('角色类型不能为空。');
		}
		$.ajax({
			url : "${basePath}/saveRole",
			type : "post",
			data : {
				"data" : JSON.stringify(data)
			},
			success : function(text) {
				$('#addrole').modal('hide');
				layer.msg('添加成功!', {
					time : 1500
				});
				$("#dg").datagrid('reload');
			},
			error : function() {
				$('#addrole').modal('hide');
				layer.msg('服务器繁忙，稍后再试！。', {
					time : 1500
				});
			}
		});
	}
	
	//删除角色的方法
	function deleteById(id){
		$.ajax({
			url:'${basePath}/deleteRoleById',
			type:"post",
			data:{"id":id},
			success:function(text){
				$('#addrole').modal('hide');
				layer.msg('删除成功!',{time:1500});
				$("#dg").datagrid('reload');
			},
			error:function(){
				$('#addrole').modal('hide');
				layer.msg('服务器繁忙，稍后再试！。',{time:1500});
			}
		});
	}
	
	//修改数据,该事件在查看弹框点击修改按钮时候触发
	function update(row){
		//json数据
		var row = row;
		//表单加载数据
		$("#boxRoleForm")[0].reset();
		$("#boxRoleForm").loadJson(row);
		//修改弹框标题
		$("#addroleLabel").html("修改角色");
		//移除表单元素只读属性【添加-修改-删除-查看 用的是同一个弹框DIV】
		$("#boxRoleForm").find("input").each(function(){
			$(this).removeAttr("readonly");
		});
		//更改按钮的显示与隐藏
		$("button[name='editBtn']").css("display","none");
		$("button[name='delBtn']").css("display","none");
		//将保存按钮的事件解除，再重写绑定修改事件
		$("button[name='saveBtn']").css("display","inline").unbind();
		$("button[name='saveBtn']").click(function(){
			//获得修改后的数据
			var name = $('#name').val();
			var type = $('#type').val();
			if (!name || name == '') {
				return layer.msg('角色名称不能为空。');
			}
			if (!type || type == '') {
				return layer.msg('角色类型不能为空。');
			}
			row.roleName=name;
			row.roleType=type;
			$.ajax({
				url : "${basePath}/updateRoleById",
				type : "post",
				data : {
					"data" : JSON.stringify(row)
				},
				success : function(text) {
					$('#addrole').modal('hide');
					layer.msg('修改成功!', {
						time : 1500
					});
					$("#dg").datagrid('reload');
				},
				error : function() {
					$('#addrole').modal('hide');
					layer.msg('服务器繁忙，稍后再试！。', {
						time : 1500
					});
				}
			});
		});
		//显示弹框
		$('#addrole').modal();
	}
	
	//显示角色详情
	function detail(index){
		//选中点击的行
		$("#dg").datagrid("checkRow",index);
		//或的该行数据，返回的是json数据
		var row = $('#dg').datagrid('getSelected');
		//表单加载数据
		$("#boxRoleForm").loadJson(row);
		//修改弹框标题
		$("#addroleLabel").html("角色信息详情");
		//将表单元素设置为只读
		$("#boxRoleForm").find("input").each(function(){
			$(this).attr("readonly","true");
		});
		//更改按钮的显示与隐藏
		$("button[name='saveBtn']").css("display","none");
		$("button[name='delBtn']").css("display","inline");
		//将保存按钮的事件解除，再重写绑定修改事件
		$("button[name='editBtn']").css("display","inline").unbind().click(function(){
			//调用更新方法
			update(row);
		});
		//给删除按钮绑定删除事件
		$("button[name='delBtn']").click(function(){
			//调用删除方法
			deleteById(row.id);
		});
		$('#addrole').modal();
	}
</script>
</head>
<body>
	<!-- =============================数据================================================================================= -->
	<div id="toolbar" style="border: none;">
		<div style="float: left;">
			<input type="text" class="form-control"
				style="width: 300px; margin-right: 10px;" value=""
				name="findContent" id="findContent" placeholder="输入角色类型 / 角色名称">
		</div>
		<span>
			<button type="button" id="find" class="btn btn-primary"> <span class="glyphicon glyphicon-search"></span>查询</button> 
			<button type="button" name="addBtn" class="btn btn-primary"> <span class="glyphicon glyphicon-plus"></span>增加角色</button>
		</span>
	</div>
	<div id="dg" style="margin-left: 170px;"></div>

	<!-- ==============================添加弹框================================================================================ -->
	<div class="modal fade" id="addrole" tabindex="-1" role="dialog"
		aria-labelledby="addroleLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="addroleLabel">添加角色</h4>
				</div>
				<div class="modal-body">
					<form id="boxRoleForm">
						<div class="form-group">
							<label for="recipient-name" class="control-label">角色名称:</label> 
							<input type="text" class="form-control" name="roleName" id="name" placeholder="请输入角色名称">
						</div>
						<div class="form-group">
							<label for="recipient-name" class="control-label">角色类型:</label> 
							<input type="text" class="form-control" id="type" name="roleType"placeholder="请输入角色类型  数字[越小范围越大]">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button style="height:34px;" type="button" class="btn btn-default" data-dismiss="modal"id="cancel"><span class="glyphicon glyphicon-share-alt">取消</button>
					<button style="height:34px;" type="button" name="editBtn" class="btn btn-primary"> <span class="glyphicon glyphicon-pencil"></span>修改</button>
					<button style="height:34px;" type="button" name="saveBtn" class="btn btn-primary"> <span class="glyphicon glyphicon-ok">保存</span></button>
					<button style="height:34px;" type='button' class='btn btn-danger'  name="delBtn"><span class="glyphicon glyphicon-trash"></span> 删除</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>