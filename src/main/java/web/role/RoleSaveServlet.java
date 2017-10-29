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
import util.IDUtil;


public class RoleSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		RoleDao dao = new RoleDaoImp();
		
		Object data = request.getParameter("data");
		JSONObject object = JSONObject.fromObject(data);
		Role role = (Role)JSONObject.toBean(object, Role.class);
		role.setId(IDUtil.getID());
		dao.saveRole(role);
		printWriter.println("ok");
	}

}
