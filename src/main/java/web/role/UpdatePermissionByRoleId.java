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
 * Servlet implementation class UpdatePermissionByRoleId
 */
public class UpdatePermissionByRoleId extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		RoleDao dao = new RoleDaoImp();
		
		String roleId = request.getParameter("id");
		String perids = request.getParameter("perids");
		String[] pids;
		if(perids.contains(",")){
			pids = perids.split(",");
		}else{
			pids = new String[]{perids};
		}
		dao.updateRolePermission(roleId,pids);
		printWriter.println("ok");
	}

}
