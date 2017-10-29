package web.permission;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PermissionDao;
import dao.imp.PermissionImp;
import entity.Permission;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class FindAllForSelect
 */
public class FindAllForSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		
		PermissionDao dao = new PermissionImp();
		List<Permission> permissions = dao.findAll();
		JSONArray array = JSONArray.fromObject(permissions);
		printWriter.println(array);
		printWriter.close();
	}

}
