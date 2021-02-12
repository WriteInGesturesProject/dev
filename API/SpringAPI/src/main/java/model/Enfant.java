package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Enfant")
public class Enfant {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	
	private long id;
	
	@Column(name="firstname")
	
	private String firstname;
	
	@Column(name="lastname")
	
	private String lastname;
	
	@Column(name="Token")
	
	private int Token;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
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
	public int getToken() {
		return Token;
	}
	public void setToken(int token) {
		Token = token;
	}
	
	public Enfant() {
		super();
	}
	public Enfant(String firstname, String lastname, int Token) {
		super();
		this.firstname = firstname;
		this.lastname = lastname;
		this.Token = Token;
	}
	
		
	
	
	

}
