<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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