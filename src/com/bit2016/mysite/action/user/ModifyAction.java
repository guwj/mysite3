package com.bit2016.mysite.action.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bit2016.mysite.dao.UserDao;
import com.bit2016.mysite.vo.UserVo;
import com.bit2016.web.Action;
import com.bit2016.web.util.WebUtil;

public class ModifyAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ModifyAction 입장");
		// 인증 여부
		HttpSession session = request.getSession();
		if( session == null ) {
			WebUtil.redirect(request, response, "/mysite3/main" );
			return;
		}
		
		UserVo authUser = (UserVo)session.getAttribute( "authUser" );
		if( authUser == null ) {
			WebUtil.redirect(request, response, "/mysite3/main" );
			return;
		}
		authUser.getNo();
		
		
		String name = request.getParameter( "name" );
		String password = request.getParameter( "password" );
		String gender = request.getParameter( "gender" );
		
		UserVo vo = new UserVo();
		vo.setNo( authUser.getNo() );
		vo.setName(name);
		vo.setPassword(password);
		vo.setGender(gender);
		
		new UserDao().update( vo );
		
		WebUtil.redirect(
			request,
			response,
			"/mysite3/user?a=modifyform&update=success" );
	}

}
