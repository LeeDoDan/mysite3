package com.javaex.vo;

public class JsonResult {
	
	//필드
	private String result; //'success' or 'fail'
	private Object data; //성공했을때 data result=success // String으로하면 문자만 가능하니 object
	private String failMsg;//실패했을때 참고 메세지 result=fail
	
	public JsonResult(String result, Object data, String failMsg) {
		super();
		this.result = result;
		this.data = data;
		this.failMsg = failMsg;
	}
	public JsonResult() {
		super();
	}
	//메서드 gs
//	public String getResult() {
//		return result;
//	}
//	public void setResult(String result) {
//		this.result = result;
//	}
//	public Object getData() {
//		return data;
//	}
//	public void setData(Object data) {
//		this.data = data;
//	}
//	public String getFailMsg() {
//		return failMsg;
//	}
//	public void setFailMsg(String failMsg) {
//		this.failMsg = failMsg;
//	}
	public void success(Object data) {
		this.result = "success";
		this.data = data;
	}
	public String getResult() {
		return result;
	}
	public Object getData() {
		return data;
	}
	public String getFailMsg() {
		return failMsg;
	}
	
	
	//메서드 일반
	//성공했을때 사용하는 메서드
	//실패했을때 사용하는 메서드
	public void fail(String msg) {
		this.result = "fail";
		this.failMsg =msg;
	}
	
	@Override
	public String toString() {
		return "JsonResult [result=" + result + ", data=" + data + ", failMsg=" + failMsg + "]";
	}
	
	
}
