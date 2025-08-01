package g3way.board.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import g3way.board.vo.UserVo;

public class UserInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		UserVo user = (UserVo) session.getAttribute("user");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		System.out.println("authentication : "+authentication);
		System.out.println("authentication.isAuthenticated() : "+authentication.isAuthenticated());
		System.out.println("authentication.getPrincipal() : "+authentication.getPrincipal());
		
		if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
			response.sendRedirect("/loginPage.do");
            return false; 
		}
		
		if (user == null) {
			Object principal = authentication.getPrincipal();
			user = new UserVo();
			
			if (principal instanceof UserDetails) {
				UserDetails userDetails = (UserDetails) principal;
				
				user.setUserId(userDetails.getUsername());
                user.setUserPw(userDetails.getPassword());
                System.out.println("사용자 아이디 : " + user.getUserId());
        	    System.out.println("사용자 비밀번호 : " + user.getUserPw());

                // 권한(Role) 설정
                for (GrantedAuthority authority : userDetails.getAuthorities()) {
                    if ("ROLE_ADMIN".equals(authority.getAuthority())) {
                    	System.out.println("권한 : " + authority.getAuthority() );
                        user.setAuthrtCd("2");
                        break;
                    } else if ("ROLE_USER".equals(authority.getAuthority())) {
                    	System.out.println("권한 : " + authority.getAuthority() );
                        user.setAuthrtCd("1");
                        break;
                    }
                }
                
                session.setAttribute("user", user);
                
			}
		}
		
		return true;
		
	}
	
	
	
	
	// 빈 껍데기
	@Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
	
	

}
