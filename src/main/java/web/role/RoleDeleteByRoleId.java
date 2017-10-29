package web.role;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RoleDao;
import dao.imp.RoleDaoImp;

/**
 * Servlet implementation class RoleDeleteByRoleId
 */
public class RoleDeleteByRoleId extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoleDeleteByRoleId() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		RoleDao dao = new RoleDaoImp();
		
		String id = request.getParameter("id");
		dao.deleteRoleById(id);
		
		printWriter.println("ok");
		printWriter.close();
	}

}
