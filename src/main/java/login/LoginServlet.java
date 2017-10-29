package login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import dao.UserDao;
import dao.imp.UserDaoImp;
import entity.User;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		//String vcode = request.getParameter("vcode");
		//String rightVcode = (String)request.getSession().getAttribute("vcode");
		//if(vcode.equalsIgnoreCase(rightVcode)){
			Subject subject=SecurityUtils.getSubject();
			UsernamePasswordToken token=new UsernamePasswordToken(username, password);
			try{
				subject.login(token);
				Session session=subject.getSession();
				UserDao userDao=new UserDaoImp();
				User user=userDao.findUserByUsername(username);
				//User user = (User)subject.getPrincipal();
				System.out.println("----------------------------");
				System.out.println(subject.getPrincipal());
				System.out.println("----------------------------");
				session.setAttribute("currentUser", user);
				response.sendRedirect("qxmanager/main.jsp");
			}catch(Exception e){
				e.printStackTrace();                                                                                   
				
				request.setAttribute("errorInfo", "用户名或者密码错误");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		//}else{
		//	request.setAttribute("errorInfo", "验证码错误");
		//	request.getRequestDispatcher("login.jsp").forward(request, response);
		//}
	}

}
