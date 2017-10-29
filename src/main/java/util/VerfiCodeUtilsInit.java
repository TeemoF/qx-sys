package util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class VerfiCodeUtilsInit {
	public static void writeCodeImage(HttpServletRequest request, HttpServletResponse response, int verfyCodeLength,
			int codeImageWidth, int codeImageHeight,String codeInSessionName) throws IOException {
		response.reset();
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/jpeg");
		// 生成随机字串
		String verifyCode = VerifyCodeUtils.generateVerifyCode(verfyCodeLength);
		request.getSession().setAttribute("vcode", verifyCode);
		// 存入会话session
		HttpSession session = request.getSession(true);
		// 删除以前的
		session.removeAttribute(codeInSessionName);
		session.setAttribute(codeInSessionName, verifyCode.toLowerCase());
		// 生成图片
		VerifyCodeUtils.outputImage(codeImageWidth, codeImageHeight, response.getOutputStream(), verifyCode);
	}
}
