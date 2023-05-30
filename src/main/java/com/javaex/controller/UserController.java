package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

@Controller
public class UserController {
	//필드
	@Autowired
	private UserService userService;
	//생성자
	//메서드 gs
	//메서드 일반
	//회원가입폼
	@RequestMapping(value="/user/joinForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String joinForm() {
		System.out.println("UserController.joinForm()");
		return "/WEB-INF/views/user/joinForm.jsp";
	}
	//회원가입
	@RequestMapping(value = "/user/join", method = {RequestMethod.GET, RequestMethod.POST})
	public String join(@ModelAttribute UserVo userVo) {
		System.out.println("UserController.join()");
		int count = userService.join(userVo);
		//count = 0;
		//System.out.println(count);
		if(count>0) {
			return "/WEB-INF/views/user/joinOk.jsp";
		}else{
			return "redirect:/user/joinForm";
		}
	}
	//로그인폼
	@RequestMapping(value = "/user/loginForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm() {
		System.out.println("UserController.loginForm()");
		return "/WEB-INF/views/user/loginForm.jsp";
	}
	//로그인
	@RequestMapping(value = "/user/login", method = {RequestMethod.GET, RequestMethod.POST})
	public String login(@ModelAttribute UserVo userVo, HttpSession session) {
		System.out.println("UserController.login()");
		UserVo authUser = userService.login(userVo);
		System.out.println(authUser);
		
		if(authUser != null) {//로그인 성공
			System.out.println("로그인 성공");
			//세션에 저장
			session.setAttribute("authUser", authUser);//setAttribute이 메서드알고잇기 !!request는 모델달라해서 dispatch Servlet
			//메인으로 리다이렉트
			return "redirect:/main";
		}else {//로그인 실패
			System.out.println("로그인 실패");
			//로그인폼
			return "redirect:/user/loginForm?result=fail";//파라미터로 꼬리달아 보낼껀데
			//파라미터에 fail이있으면 =><c:if test="${param.result=='fail'}">
		}
	}
	//로그아웃
	@RequestMapping(value = "/user/logout", method = {RequestMethod.GET, RequestMethod.POST})
	public String logout(HttpSession session) {
		System.out.println("UserController.logout()");
		session.removeAttribute("authUser");
		session.invalidate();// 웹 애플리케이션에서 사용되는 세션을 무효화하는 역할 
		//현재 사용 중인 세션에 저장된 데이터를 삭제하고, 해당 세션을 더 이상 사용할 수 없게 
		return "redirect:/main";
	}
	//회원정보 수정폼
	@RequestMapping(value = "/user/modifyForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String modifyForm(HttpSession session, Model model) {//
		System.out.println("UserController.modifyForm()");
		UserVo authUser = (UserVo)session.getAttribute("authUser");//횡변환 한번
		int no = authUser.getNo();//authUser의 no가져와서 int no에 저장
		UserVo userVo = userService.modifyForm(no);//userService에서 no불러오기
		//((UserVo)session.getAttribute("authUser")).getNo();//나중에 잘해지면 이렇게 한번에 !!
		model.addAttribute("userVo", userVo);//request "userVo"
		return "/WEB-INF/views/user/modifyForm.jsp";//forward
	}
	//회원정보 수정
	@RequestMapping(value = "/user/modify", method = {RequestMethod.GET, RequestMethod.POST})
	public String modify(HttpSession session, @ModelAttribute UserVo userVo) {//우리가 만든이름이랑 vo이름이랑 같고, value에 바뀐값을 넣을거?
	    System.out.println("UserController.modify()" + userVo);
        UserVo authUser =  (UserVo)session.getAttribute("authUser");
        authUser.setName(userVo.getName());
        int no = authUser.getNo();
		return "redirect:/main";
	}
	//
	
	
}




