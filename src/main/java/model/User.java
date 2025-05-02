package model;

public class User {
	private int customerId;
	private String firstname;
	private String lastname;
	private String username;
	private String passwordHash;
	private String email;
	private String phonenumber;
	
	
	
	public User() {
		
		
	}



	public int getCustomerId() {
		return customerId;
	}



	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}



	public User(int customerId, String firstname, String lastname, String username, String passwordHash, String email,
			String phonenumber) {
		super();
		this.customerId = customerId;
		this.firstname = firstname;
		this.lastname = lastname;
		this.username = username;
		this.passwordHash = passwordHash;
		this.email = email;
		this.phonenumber = phonenumber;
	}



	public User(String firstname, String lastname, String username, String passwordHash, String email,
			String phonenumber) {
		super();
		this.firstname = firstname;
		this.lastname = lastname;
		this.username = username;
		this.passwordHash = passwordHash;
		this.email = email;
		this.phonenumber = phonenumber;
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



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public String getPasswordHash() {
		return passwordHash;
	}



	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPhonenumber() {
		return phonenumber;
	}



	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	
	
	
}
