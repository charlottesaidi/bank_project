package com.nsf.bank.service.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

import com.nsf.bank.service.UserService;

public class AppAuthProvider  implements AuthenticationManager {

    @Autowired
    private UserService userService;

    @Override
    public Authentication authenticate(Authentication authentification) throws AuthenticationException{

        UsernamePasswordAuthenticationToken auth = (UsernamePasswordAuthenticationToken) authentification;

        String username = auth.getName();

        UserDetails user = userService.loadUserByUsername(username, auth.getCredentials().toString());

        if(user == null) {
            throw new BadCredentialsException("Identifiants invalides");
        }
        return new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
    }
}
