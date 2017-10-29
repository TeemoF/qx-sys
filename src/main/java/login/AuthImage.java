package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.VerfiCodeUtilsInit;

/**
 * Servlet implementation class AuthImage
 */
public class AuthImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		//验证码的个数
		int verfyCodeLength = 3;
		//验证码图片的宽度
		int codeImageWidth = 100;
		//验证码图片的高度
		int codeImageHeight = 30;
		//验证码放在session中的名称
		String codeInSessionName = "verCode";
		//调用工具方法向jsp输出图片
		VerfiCodeUtilsInit.writeCodeImage(request, response, verfyCodeLength, codeImageWidth, codeImageHeight,codeInSessionName);
	}

}
