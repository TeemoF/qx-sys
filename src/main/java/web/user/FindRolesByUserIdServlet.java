package web.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BaseDao;
import dao.imp.BaseDaoImp;
import entity.Role;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class FindRolesByUserIdServlet
 */
public class FindRolesByUserIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		String userId = request.getParameter("userid");
		BaseDao dao = new BaseDaoImp();
		List<Role> roles = dao.findRolesByUserId(userId);
		JSONArray array = JSONArray.fromObject(roles);
		writer.println(array);
		writer.close();
	}

}
