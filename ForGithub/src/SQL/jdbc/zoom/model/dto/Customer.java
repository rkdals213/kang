package jdbc.zoom.model.dto;

import java.sql.Date;

// DTC - customer 테이블의 데이터 이동을 위한 클래스
// JavaBeans = private member 변수, setter/getter, default constructor
//			   필요하다면 parameter 생성자, tostring

public class Customer {
	// 변수 선언 시 기본형 대신 객체형을 쓰자!	
	private Integer customerId; // cammel case vs db 쪽은 snake case
	private Integer storeId;
	private String firstName;
	private String lastName;
	private String email;
	private Integer addressId;
	private Integer active;
	private Date createDate;
	private Date lastUpdate;
	
	public Customer() {}

	public Customer(Integer customerId, Integer storeId, String firstName, String lastName, String email,
			Integer addressId, Integer active, Date createDate, Date lastUpdate) {
		super();
		this.customerId = customerId;
		this.storeId = storeId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.addressId = addressId;
		this.active = active;
		this.createDate = createDate;
		this.lastUpdate = lastUpdate;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	public Integer getActive() {
		return active;
	}

	public void setActive(Integer active) {
		this.active = active;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(Date lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", storeId=" + storeId + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", email=" + email + ", addressId=" + addressId + ", active=" + active
				+ ", createDate=" + createDate + ", lastUpdate=" + lastUpdate + "]";
	};
	
	

}
