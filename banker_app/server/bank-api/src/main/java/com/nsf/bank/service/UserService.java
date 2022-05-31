package com.nsf.bank.service;

import com.nsf.bank.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.nsf.bank.repository.UserRepository;

@Service
public class UserService  implements UserDetailsService{

    @Autowired
    private UserRepository userRepository;

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findUserWithName(username)
                .orElseThrow(() -> new UsernameNotFoundException("Cet utilisateur n'existe pas"));
    }

    public User updateUserDetails(User userDetails, User user) {
        if(userDetails.getEmail() != null) {
            user.setEmail(userDetails.getEmail());
        }
        if(userDetails.getLast_name() != null) {
            user.setLast_name(userDetails.getLast_name());
        }
        if(userDetails.getPhone() != null) {
            user.setPhone(userDetails.getPhone());
        }
        if(userDetails.getAddress_city() != null) {
            user.setAddress_city(userDetails.getAddress_city());
        }
        if(userDetails.getAddress_country() != null) {
            user.setAddress_country(userDetails.getAddress_country());
        }
        if(userDetails.getAddress_street() != null) {
            user.setAddress_street(userDetails.getAddress_street());
        }
        if(userDetails.getAddress_zipcode() != null) {
            user.setAddress_zipcode(userDetails.getAddress_zipcode());
        }

        return user;
    }
}
