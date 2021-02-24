package com.example.demo.Exception;

import java.util.Date;

public class ErrorDetails {
	private String message;
	private Date timestamp;
	private String details;
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}
	public ErrorDetails(Date timestamp,String message,  String details) {
		super();
		this.message = message;
		this.timestamp = timestamp;
		this.details = details;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	
	

}
