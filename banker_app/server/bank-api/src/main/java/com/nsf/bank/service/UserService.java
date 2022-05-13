package com.nsf.bank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.nsf.bank.repository.UserRepository;

@Service
public class UserService  implements UserDetailsService{

    @Autowired
    private UserRepository userRepository;

    public UserDetails loadUserByUsername(String username, String password) throws UsernameNotFoundException {
        return userRepository.findUserWithNameAndPassword(username, password)
                .orElseThrow(() -> new UsernameNotFoundException("Identifiants invalides"));
    }

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findUserWithName(username)
                .orElseThrow(() -> new UsernameNotFoundException("Identifiants invalides"));
    }


}
