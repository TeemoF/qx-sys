package web.role;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PermissionDao;
import dao.RoleDao;
import dao.UserDao;
import dao.imp.PermissionImp;
import dao.imp.RoleDaoImp;
import dao.imp.UserDaoImp;
import entity.Permission;
import entity.Role;
import entity.User;
import net.sf.json.JSONArray;


public class RoleListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		
		RoleDao dao = new RoleDaoImp();
		
		int page  = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		//sn--查询框的值
		String sn = request.getParameter("sn");
		
		List<Role> roles = dao.findAll(page,rows,sn);
		int size = dao.getSize();
		//将数据封装为Map对象
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("rows", roles);
		map.put("total", size);
		JSONArray jsonArray = JSONArray.fromObject(map);
		//将JSON对象转为JSON字符串
		String jsonStr = jsonArray.toString();
		PrintWriter out = null;
		try {
		    out = response.getWriter();
		    //向前端响应JSON字符串
		    out.write(jsonStr.substring(1,jsonStr.length()-1));
		} catch (IOException e) {
		    e.printStackTrace();
		} finally {
		    if (out != null) {
		        out.close();
		    }
		}
		
	}

}
