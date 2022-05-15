package com.nsf.bank.entity;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "users", uniqueConstraints = { @UniqueConstraint(columnNames = "email") })
public class User implements UserDetails{
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_user")
	private int id;

	@Column(unique = true)
	private String email;

	private String username;
	
	private String password;

	@NotBlank
	private String first_name;

	private String last_name;

	private Date birthdate;

	private String address_street;

	private String address_city;

	private String address_zipcode;

	private String address_country;

	@CreatedDate
	private Date created_at;

	@LastModifiedDate
	private Date updated_at;

	@ElementCollection(fetch =  FetchType.EAGER)
	private List<Role> role;

	@OneToOne(orphanRemoval = true, mappedBy = "user")
	private Customer customer;

	@OneToOne(orphanRemoval = true, mappedBy = "user")
	private Banker banker;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return role;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.password;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.username;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getAddress_street() {
		return address_street;
	}

	public void setAddress_street(String address_street) {
		this.address_street = address_street;
	}

	public String getAddress_city() {
		return address_city;
	}

	public void setAddress_city(String address_city) {
		this.address_city = address_city;
	}

	public String getAddress_zipcode() {
		return address_zipcode;
	}

	public void setAddress_zipcode(String address_zipcode) {
		this.address_zipcode = address_zipcode;
	}

	public String getAddress_country() {
		return address_country;
	}

	public void setAddress_country(String address_country) {
		this.address_country = address_country;
	}

	public Date getCreated_at() {
		return created_at;
	}

	@PrePersist
	public void setCreated_at() {
		if(this.created_at == null) {
			this.created_at = new Date();
		}
	}

	public Date getUpdated_at() {
		return updated_at;
	}

	@PreUpdate
	public void setUpdated_at() {
		if(this.updated_at == null) {
			this.updated_at = new Date();
		}
	}

	public List<Role> getRole() {
		return role;
	}

	public void setRole(List<Role> role) {
		this.role = role;
	}
}
