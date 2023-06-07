package com.javaex.vo;

public class JsonResult {

	
	//필드
	private String result;     /* "success' or "fail" */
	private Object data;       /* 성공했을때 result="success" 일때 데이타(어떤 데이타가 들어갈지 모르기에 object로 선택) */
	private String failMsg;    /* 실패했을때 result="fail"일때 참고할 수 있는 메세지 */
	
	
	//생성자
	public JsonResult() {
		super();
	}

	public JsonResult(String result, Object data, String failMsg) {
		super();
		this.result = result;
		this.data = data;
		this.failMsg = failMsg;
	}

	
	//메소드 gs <==불필요해서 gs 삭제하고 일반 메소드 생성
	public String getResult() {
		return result;
	}

	public Object getData() {
		return data;
	}

	public String getFailMsg() {
		return failMsg;
	}
	
	//메소드 일반
	
	//성공했을때 사용하는 메소드
	public void success(Object data) {
		this.result = "success";
		this.data = data;
	}


	//실패했을때 사용하는 메소드
	public void fail(String msg) {
		this.result = "fail";
		this.data = msg;
	}
	
	@Override
	public String toString() {
		return "JsonResult [result=" + result + ", data=" + data + ", failMsg=" + failMsg + "]";
	}
}