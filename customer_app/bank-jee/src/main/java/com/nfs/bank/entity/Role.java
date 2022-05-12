package com.nfs.bank.entity;

public enum Role {
	ROLE_SUPER_ADMIN, ROLE_ADMIN, ROLE_USER;

	public String getAuthority() {
		// TODO Auto-generated method stub
		return name();
	}

}
