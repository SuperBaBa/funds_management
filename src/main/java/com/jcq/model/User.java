package com.jcq.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class User {
	private String id;

	private String accountNumber;

	private String phoneNumber;

	private String idNumber;

	private String password;

	private Double balance;

	private String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;

	private Integer gender;

	private String address;

	private String email;

	private String headProtrait;

	private Integer status;

	private Records records;


	public Records getRecords() {
		return records;
	}

	public void setRecords(Records records) {
		this.records = records;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber == null ? null : accountNumber.trim();
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber == null ? null : phoneNumber.trim();
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber == null ? null : idNumber.trim();
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password == null ? null : password.trim();
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address == null ? null : address.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public String getHeadProtrait() {
		return headProtrait;
	}

	public void setHeadProtrait(String headProtrait) {
		this.headProtrait = headProtrait == null ? null : headProtrait.trim();
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", accountNumber=" + accountNumber + ", phoneNumber=" + phoneNumber + ", idNumber="
				+ idNumber + ", password=" + password + ", balance=" + balance + ", name=" + name + ", birthday="
				+ birthday + ", gender=" + gender + ", address=" + address + ", email=" + email + ", headProtrait="
				+ headProtrait + ", status=" + status + "]";
	}

}