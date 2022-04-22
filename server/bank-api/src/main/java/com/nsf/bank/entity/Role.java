package com.nsf.bank.entity;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
	ROLE_SUPER_ADMIN, ROLE_ADMIN, ROLE_USER;

	@Override
	public String getAuthority() {
		// TODO Auto-generated method stub
		return name();
	}

}
