<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色列表</title>
<jsp:include page="../common.jsp"></jsp:include>
<style type="text/css">
body{
	width:1200px;
	margin:0px auto;
}

/* 修改easyui默认样式的css */
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
 .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber
{
    text-overflow: ellipsis;
}
.panel-header, .panel-body {
border-width: 0px;
}
</style>
<script>
	$(function() {
		$("#dg").datagrid(
		{
			//title : "角色权限分配信息",
			rownumbers : true,
			striped : true,
			/* nowrap:false, */
			singleSelect : false,
			autoRowHeight : false,
			pagination : true,
			pageSize : 10,
			pageList : [10, 20, 30, 40 ],
			//fitColumns : true,
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
						width : 280,
						formatter : function(value, role, index) {
							return role.id;
						}
					},
					{
						field : 'name',
						title : '角色名称',
						align : 'center',
						width : 200,
						formatter : function(value, role, index) {
							return role.roleName;
							//return '<button type="button" onclick="detail('+index+')" class="btn btn-link">'+role.roleName+'</button>';
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
					},
					{
						field : 'permissions',
						title : '拥有权限',
						align : 'center',
						width : 380,
						formatter : function(value, role, index) {
							var str = "";
							$(role.permissions).each(function(index,permission){
								str += permission.name+(index==(role.permissions.length-1)?"":",");
							});
							return '<p class="tooltip-options" ><a href="#" data-toggle="tooltip" style="color:black;" title="<h5>'+str+'</h5>">'+str+'</a></p>';
						}
					},
					{
						field:"xxxxx",
						title:"操作",
						align:"center",
						width:200,
						formatter:function(value, role, index){
							return '<i class="glyphicon glyphicon-share-alt"></i><a href="javascript:selectPermissionById('+index+');">选择权限</a>';
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
				 $(".tooltip-options a").tooltip({html : true });
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
		//更改表格标题行颜色
		$($(".datagrid-header-row").children("td")).each(function(){
			$(this).css("background","#F0FFF0");
		});
		
		
		//------------------------------------------------------------------------------------
		//给弹框追加业务表单form
		$(".modal-body:eq(0)").append($("#boxRoleForm"));
		
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
			//清空保存按钮的绑定事件【保存按钮两个功能：1修改数据的保存 2新添加数据的保存 所以要区分】
			$("button[name='saveBtn']").unbind();
			
			//给保存按钮添加默认绑定数据保存功能事件
			$("button[name='saveBtn']").click(function(){
				//掉用添加角色方法
				addRole();
			});
			$("#addroleLabel").html("添加角色");
			$("button[name='editBtn']").css("display","none");
			$("button[name='delBtn']").css("display","none");
			//将表单重置
			$("#boxRoleForm")[0].reset();
			//移除表单元素只读属性【添加-修改-删除-查看 用的是同一个弹框DIV】
			$("#boxRoleForm").find("input").each(function(){
				$(this).removeAttr("readonly");
			});
			//显示弹框
			$('#addrole').modal();
		});
		
	});
	
	//添加新的角色,点击保存的时候触发该方法【保存按钮默认绑定事件】
	function addRole() {
		var name = $('#name').val(), type = $('#type').val();
		var data = $("#boxRoleForm").serializeObject();
		console.log(data)
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
				$('#dg').datagrid('clearSelections');
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
					$('#dg').datagrid('clearSelections');
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
	
	//显示角色详情，点击表格中角色名字触发该函数
	function detail(index){
		//选中点击的行
		$("#dg").datagrid("checkRow",index);
		//或的该行数据，返回的是json数据
		var row = $('#dg').datagrid('getSelected');
		//表单加载数据
		$("#boxRoleForm")[0].reset();
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
		$("button[name='delBtn']").unbind().click(function(){
			//调用删除方法
			deleteById(row.id);
		});
		$('#addrole').modal();
	}
	
	/*
	*根据角色ID选择权限，分配权限操作。
	*/
	function selectPermissionById(index){
		//选中点击的行
		$("#dg").datagrid("checkRow",index);
		//或的该行数据，返回的是json数据
		var row = $('#dg').datagrid('getSelected');
		var data = [];
		$.each(row.permissions,function(index,per){
			data.push(per.id);
		});
		$("#selectPermission").modal();
		$.post("${basePath}/findAll",{id:row.id},function(result){
			$('#dg').datagrid('clearSelections');
			if(result && result.length){
				var html =[];
				html.push('<div class="checkbox"><label><input type="hidden" name="roleid" value="'+row.id+'"/><input type="checkbox"  name="selectAllBox">全选</label></div>');
				for(var i=0;i<result.length;i++){
					html.push("<div class='checkbox'><label>");
					html.push("<input type='checkbox' selectBox='' id='");
					html.push(result[i].id);
					html.push("'");
					if(data && data.length){
						for(var j=0;j<data.length;j++){
							if(result[i].id==data[j]){
								html.push(" checked='checked'");
							}
						}
					}
					html.push("name='");
					html.push(result[i].name);
					html.push("'/>");
					html.push(result[i].name);
					html.push('</label></div>');
					$('#boxPermissionForm').html(html.join(''));
				}
				//全选，全部选
				$("input[name='selectAllBox']").click(function(){
					if($(this).prop("checked")){
						$("input[type='checkbox']").each(function(){
							$(this).prop('checked',true);
						});
					}else{
						$("input[type='checkbox']").each(function(){
							$(this).prop('checked',false);
						});
					}
				});
			}else{
				return layer.msg('没有获取到权限数据，请先添加权限数据。',1500);
			}
		},'json');
	}
	
	//选择完权限后保存
	function selectPermission(){
		var obj = $("input:checked");
		var str = "";
		console.log(obj);
		$(obj).each(function(index,val){
			console.log(index);
			if(this.id)
				str = str+this.id+(index==(obj.length-1)?"":",");
		})
		var roleid = $("input[name='roleid']").val();
		$.ajax({
			url : "${basePath}/updatePermissionByRoleId",
			type : "post",
			data : {
				"id" : roleid,
				"perids":str
			},
			success : function(text) {
				$('#selectPermission').modal('hide');
				layer.msg('修改成功!', {
					time : 1500
				});
				$("#dg").datagrid('reload');
				$('#dg').datagrid('clearSelections');
			},
			error : function() {
				$('#selectPermission').modal('hide');
				layer.msg('服务器繁忙，稍后再试！。', {
					time : 1500
				});
			}
		});
		$('#boxPermissionForm').html("loading...");
	}
	

	
</script>
</head>
<body>


	<!-- =============================easyui表格数据================================================================================= -->
	<div id="toolbar" style="border: none;">
		<div style="float: left;">
			<input type="text" class="form-control"
				style="width: 300px; margin-right: 10px;" value=""
				name="findContent" id="findContent" placeholder="输入角色类型 / 角色名称">
		</div>
		<span>
			<button type="button" id="find" class="btn btn-primary"> <span class="glyphicon glyphicon-search"></span>查询</button> 
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
					<h4 class="modal-title" id="addroleLabel"></h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button style="height:34px;" type="button" class="btn btn-default" data-dismiss="modal"id="cancel"><span class="glyphicon glyphicon-share-alt">取消</button>
					<button style="height:34px;" type="button" name="editBtn" class="btn btn-primary"> <span class="glyphicon glyphicon-pencil"></span>修改</button>
					<button style="height:34px;" type="button" name="saveBtn" class="btn btn-primary"> <span class="glyphicon glyphicon-ok">保存</span></button>
					<button style="height:34px;" type='button' class='btn btn-danger'  name="delBtn"><span class="glyphicon glyphicon-trash"></span> 删除</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- ===============================业务数据表单======需要追加到弹框中================ -->
	<div id="formdiv" style="display:none;">
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
	
	<!-- =======================================选择权限弹框========================================== -->
	<div class="modal fade bs-example-modal-sm" id="selectPermission" tabindex="-1" role="dialog" aria-labelledby="selectPermissionLabel">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title" id="selectPermissionLabel">选择权限</h4>
	      </div>
	      <div class="modal-body" style="overflow-y:scroll;height:500px;">
	        <form id="boxPermissionForm">
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
</body>
</html>