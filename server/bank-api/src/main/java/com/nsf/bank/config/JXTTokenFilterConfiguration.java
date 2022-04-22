package com.nsf.bank.config;

import org.springframework.security.config.annotation.SecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.DefaultSecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class JXTTokenFilterConfiguration  extends SecurityConfigurerAdapter<DefaultSecurityFilterChain, HttpSecurity>{

	private JWTTokenProvider provider;
	
	public JXTTokenFilterConfiguration(JWTTokenProvider p) {
		this.provider = p;
	}
	
	@Override
	public void configure(HttpSecurity http) throws Exception{
		JWTTokenFilter filter = new JWTTokenFilter(provider);
		http.addFilterBefore(filter, UsernamePasswordAuthenticationFilter.class);
	}
}
