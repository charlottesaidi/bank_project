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
import org.springframework.security.crypto.password.PasswordEncoder;

public class AppAuthProvider  implements AuthenticationManager {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Authentication authenticate(Authentication authentification) throws AuthenticationException{

        UsernamePasswordAuthenticationToken auth = (UsernamePasswordAuthenticationToken) authentification;

        String username = auth.getName();
        String providedPassword = auth.getCredentials().toString();

        UserDetails user = userService.loadUserByUsername(username);

        if(!passwordEncoder.matches(providedPassword, user.getPassword())) {
            throw new BadCredentialsException("Identifiants invalides");
        }

        return new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
    }
}
