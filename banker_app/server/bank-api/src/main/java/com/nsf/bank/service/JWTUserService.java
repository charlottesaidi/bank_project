package com.nsf.bank.service;

import com.nsf.bank.entity.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.nsf.bank.config.JWTTokenProvider;
import com.nsf.bank.entity.User;
import com.nsf.bank.repository.UserRepository;

import java.util.ArrayList;
import java.util.List;

@Service
public class JWTUserService implements UserDetailsService {
	
	@Autowired
	  private UserRepository userRepository;

	  @Autowired
	  private PasswordEncoder passwordEncoder;

	  @Autowired
	  private JWTTokenProvider jwtTokenProvider;

	  @Autowired
	  private AuthenticationManager authenticationManager;

	  public String signin(String username, String password) {
	      authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
	      return jwtTokenProvider.createToken(username, userRepository.findUserWithName(username).get().getRole());
	  }

	  public String signup(User user) {
	      user.setPassword(passwordEncoder.encode(user.getPassword()));
		  List<Role> roles = new ArrayList<>();
		  roles.add(Role.ROLE_USER);
		  user.setRole(roles);
	      userRepository.save(user);
	      return jwtTokenProvider.createToken(user.getUsername(), user.getRole());
	  }

	public List<User> getAll(){
		return userRepository.findAll();
	}
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepository.findUserWithName(username)
				.orElseThrow(() -> new UsernameNotFoundException("Utilisateur introuvable"));
		return new org.springframework.security.core.userdetails.User(
				user.getUsername(), user.getPassword(), user.getRole());
	}
}
