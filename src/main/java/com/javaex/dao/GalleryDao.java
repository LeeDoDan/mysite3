package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GalleryVo;
import com.javaex.vo.UserVo;

@Repository
public class GalleryDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	//갤러리 리스트
	public List<GalleryVo> selectList() {
		System.out.println("GalleryDao.selectList()");
		List<GalleryVo> galleryList = sqlSession.selectList("gallery.selectList");
		return galleryList;
	}
	public UserVo userName(int userNo) {
		UserVo userVo = sqlSession.selectOne("gallery.selectOne",userNo);
		System.out.println(userVo);
		return userVo;
	}
	//갤러리 등록
	public int insertGallery(GalleryVo galleryVo) {
		System.out.println("GalleryDao.inserGallery()");
		int count =sqlSession.insert("gallery.insertGallery", galleryVo);
		return count;
	}

	//갤러리 삭제
	public void delete(GalleryVo galleryVo) {
		System.out.println("GalleryVo.delete()");
		
	}

}
