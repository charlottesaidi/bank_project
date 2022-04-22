package com.nsf.bank.controller;

import com.nsf.bank.entity.Customer;
import com.nsf.bank.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.nsf.bank.entity.User;
import com.nsf.bank.service.JWTUserService;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {
	
	@Autowired
	private JWTUserService userService;

	@Autowired
	private UserRepository userRepository;

	@RequestMapping("/")
	public ResponseEntity<List<User>> getAll(){
		return ResponseEntity.ok().body(userService.getAll());
	}

	@RequestMapping(value = "/{id}", produces = "application/json")
	public User get(@PathVariable(value="id") Integer id){
		return userRepository.getOne(id);
	}

	@PostMapping("/signin")
	public String login(@RequestParam("username") String username, @RequestParam("pass") String password) {
		return userService.signin(username, password);
	}
	@PostMapping("/create")
	public String create(@RequestParam("email") String username, @RequestParam("pass") String password, @RequestParam("first_name") String firstName, @RequestParam("last_name") String lastName) {
		User user = new User();
		user.setPassword(password);
		user.setEmail(username);
		user.setFirst_name(firstName);
		user.setLast_name(lastName);
		user.setUsername(user.getEmail());
		return userService.signup(user);
	}

}
