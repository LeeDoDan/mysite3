package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.GalleryService;
import com.javaex.vo.GalleryVo;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping(value="/gallery")
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;
	
	//갤러리 리스트
	@RequestMapping(value="/list", method= {RequestMethod.POST, RequestMethod.GET})
	public String list(Model model) {
		System.out.println("GalleryController.list()");
		List<GalleryVo> galleryList =galleryService.getList();
		
		for(GalleryVo galleryVo : galleryList) {
			int userNo = galleryVo.getUserNo();
			UserVo userVo =galleryService.userNameByUserNo(userNo);
			galleryVo.setUserVo(userVo);
		}
		model.addAttribute("galleryList",galleryList);
		return "gallery/list";
	}
	//갤러리 등록
	@RequestMapping(value="/add", method = {RequestMethod.GET, RequestMethod.POST})
	public String add(@RequestParam("file") MultipartFile file,
			@RequestParam("userNo") int userNo, @RequestParam("content") String content) {
		System.out.println("GalleryController.add()");
		galleryService.addGallery(file,userNo,content);
		return "redirect:/gallery/list";
	}
	
	//갤러리 삭제
	@RequestMapping(value="/delete", method = {RequestMethod.GET, RequestMethod.POST})
	public String delete(@ModelAttribute GalleryVo galleryVo) {
		System.out.println("GalleryController.delete()");
		//gallryService.delete(galleryVo);
		return "redirect:/list";
	}
//	//갤러리 삭제 폼
//	@RequestMapping(value="/deleteForm", method = {RequestMethod.GET, RequestMethod.POST})
//	public String deleteForm(@ModelAttribute GalleryVo galleryVo, @RequestParam("no") int no) {//no의 파라미터가져와서~~
//		System.out.println("GalleryController.deleteForm()");
//		return "gallery/deleteForm";
//	}
}
