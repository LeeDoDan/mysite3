package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.GalleryDao;
import com.javaex.vo.GalleryVo;
import com.javaex.vo.UserVo;

@Service
public class GalleryService {
	String saveDir = "C:\\javaStudy\\upload";
	
	@Autowired
	private GalleryDao galleryDao;
	
	//갤러리 리스트
	public List<GalleryVo> getList() {
		System.out.println("GalleryService.getList()");
		List<GalleryVo> galleryVo =galleryDao.selectList();
		return galleryVo;
	}
	public UserVo userNameByUserNo(int userNo) {
		UserVo userVo = galleryDao.userName(userNo);
		return userVo;
	}
	
	//갤러리 등록
	public void addGallery(MultipartFile file, int userNo, String content) {
		System.out.println("GalleryService.addGallery()");
		System.out.println("FileuploadService.restore()");
		System.out.println(file.getOriginalFilename());
		
		//원 파일 이름
		String orgName = file.getOriginalFilename();
		System.out.println("orgName:"+orgName);
		
		//확장자
		String exName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		System.out.println("exName:"+exName);
		System.out.println("exe:"+file.getOriginalFilename().lastIndexOf("."));//.앞까지의 글자가 몇개
		//substring(n)-n번째 부터 몇개
		//lastIndexOf(n)-인덱스 n부터 뒤에꺼 가져오기
		
		//저장 파일 이름
		String saveName = System.currentTimeMillis()+UUID.randomUUID().toString()+exName;
		System.out.println("saveName :"+saveName);
		
		//파일패스 (어느경로에 어떤이름으로)
		String filePath = saveDir + "\\"+saveName;
		System.out.println("filePath :"+filePath);
		
		//파일 사이즈
		long fileSize = file.getSize();
		System.out.println("filesize :"+fileSize);
		
		//파일 업로드(사용자 파일 복사 -하드디스크 저장)
		try {
			byte[] fileData = file.getBytes();
			OutputStream out = new FileOutputStream(filePath);
			BufferedOutputStream bout = new BufferedOutputStream(out);
			bout.write(fileData);
			bout.close();
		}catch (IOException e) {
			e.printStackTrace();
		}
		//db에 저장
		GalleryVo galleryVo= new GalleryVo(0,userNo,content,filePath,orgName,saveName,fileSize);
		System.out.println(galleryVo);
		
		galleryDao.insertGallery(galleryVo);
		
		
	}
	//갤러리 삭제
	public void delete(GalleryVo galleryVo) {
		System.out.println("GalleryService.delete()");
	}


}
