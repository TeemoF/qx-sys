package web.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import dao.imp.UserDaoImp;

/**
 * Servlet implementation class UpdateUserRoleByUserIdServlet
 */
public class UpdateUserRoleByUserIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String userId = request.getParameter("userId");
		String ids = request.getParameter("roleIds");
		String[] roleIds;
		if(ids.contains(",")){
			roleIds = ids.split(",");
		}else{
			roleIds = new String[]{ids};
		}
		UserDao dao = new UserDaoImp();
		dao.updateUserRoleById(userId, roleIds);
	}

}
