package web.permission;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PermissionDao;
import dao.imp.PermissionImp;


public class PermissionDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public PermissionDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printWriter = response.getWriter();
		PermissionDao dao = new PermissionImp();
		
		String id = request.getParameter("id");
		System.out.println(id);
		dao.deletePermissionById(id);
		
		printWriter.println("ok");
		printWriter.close();
	}

}
