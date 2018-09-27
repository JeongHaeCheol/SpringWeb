package my.custom.project.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
	
	private String loginId = "username";
	private String defaultFailureURI = "/login?error=1";
	
	

	@Override
	public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse res, AuthenticationException exception)
			throws IOException, ServletException {
		req.setAttribute("username",req.getParameter(loginId));
		req.setAttribute("password", "");
		req.getRequestDispatcher(defaultFailureURI).forward(req, res);
	    //로그인 실패는 세션이나 DB에 영향을 주지 않기 때문에 redirect가 아닌 forward를 사용한다.
		//res.sendRedirect(req.getContextPath() + "/login?error=1");
		
	}


}
