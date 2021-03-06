package com.example.demo.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "enfants")
public class Enfant {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	
	private long id;
	
	@Column(name="firstname")
	
	private String firstname;
	
	@Column(name="lastname")
	
	private String lastname;
	
	@Column(name="token")
	
	private int token;
	
	public long getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public int gettoken() {
		return token;
	}
	public void settoken(int token) {
		this.token = token;
	}
	
	public Enfant() {
		super();
	}
	public Enfant(String firstname, String lastname, int token) {
		super();
		this.firstname = firstname;
		this.lastname = lastname;
		this.token = token;
	}
	
		
	
	
	

}
