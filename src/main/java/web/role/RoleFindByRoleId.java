package web.role;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RoleDao;
import dao.imp.RoleDaoImp;
import entity.Role;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class RoleFindByRoleId
 */
public class RoleFindByRoleId extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/JSON;charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		RoleDao dao = new RoleDaoImp();
		
		String id = request.getParameter("id");
		Role role = dao.findRoleById(id);
		JSONObject object = JSONObject.fromObject(role);
		printWriter.println(object);
		printWriter.close();
	}

}
