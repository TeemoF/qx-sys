package web.permission;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PermissionDao;
import dao.imp.PermissionImp;
import entity.Permission;
import net.sf.json.JSONObject;
import util.IDUtil;

/**
 * Servlet implementation class PermissionSaveServlet
 */
public class PermissionSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		PermissionDao dao = new PermissionImp();
		
		Object data = request.getParameter("data");
		JSONObject object = JSONObject.fromObject(data);
		Permission permission = (Permission)JSONObject.toBean(object, Permission.class);
	
		permission.setId(IDUtil.getID());
		dao.savePermission(permission);
		printWriter.println("ok");
	}

}
