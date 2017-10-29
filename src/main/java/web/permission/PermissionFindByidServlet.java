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

/**
 * Servlet implementation class PermissionFindByidServlet
 */
public class PermissionFindByidServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/JSON;charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		PermissionDao dao = new PermissionImp();
		
		String id = request.getParameter("id");
		Permission permission = dao.findPermissionById(id);
		JSONObject object = JSONObject.fromObject(permission);
		printWriter.println(object);
		printWriter.close();
	}

}
