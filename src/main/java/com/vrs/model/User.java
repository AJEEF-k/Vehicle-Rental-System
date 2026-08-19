package com.vrs.model;

/**
 * 
 */
public class User {
   
	private int userId;
	private String fullName;
	private String phoneNumber;
	private String email;  
	private String password;
	private String role;
	private String accountStatus; 
	
	
	public User() {
		
	}
	
	public User(int userId, String fullName, String phoneNumber, String email, String password, String role, String accountStatus ) { 
		
		this.userId=userId;
		this.fullName=fullName;
		this.phoneNumber=phoneNumber;
		this.email=email;
		this.password=password;
		this.role=role;
		this.accountStatus=accountStatus;
	}
	
	 public User(String fullName, String email, String password, String phoneNumber, String role, String accountStatus) {
     this.fullName = fullName;
     this.email = email;   
     this.password = password;
     this.phoneNumber = phoneNumber;
     this.role = role;
     this.accountStatus = accountStatus;
     
    }
	 

    
    public int getUserId() {
		return userId;
	}

	 public void setUserId(int userId) {
		 this.userId = userId;   
	 }

	 public String getFullName() {
		 return fullName;
	 }

	 public void setFullName(String fullName) {
		 this.fullName = fullName;
	 }

	 public String getPhoneNumber() {
		 return phoneNumber;
	 }

	 public void setPhoneNumber(String phoneNumber) {
		 this.phoneNumber = phoneNumber;
	 }

	 public String getEmail() {
		 return email;
	 }

	 public void setEmail(String email) {
		 this.email = email;
	 }

	 public String getPassword() {
		 return password;
	 }

	 public void setPassword(String password) {
		 this.password = password;
	 }

	 public String getRole() {
		 return role;
	 }

	 public void setRole(String role) {
		 this.role = role;
	 }

	 public String getAccountStatus() {
		 return accountStatus;
	 }

	 public void setAccountStatus(String accountStatus) {
		 this.accountStatus = accountStatus;
	 }
	 

	@Override
	public String toString() {
		return "User [userId=" + userId + ", fullName=" + fullName + ", phoneNumber=" + phoneNumber + ", email=" + email
				+ ", password=" + password + ", role=" + role + ", accountStatus=" + accountStatus + "]";
	}
	
    
    
}
