package com.nsf.bank.controller;

import com.nsf.bank.entity.Account;
import com.nsf.bank.entity.Customer;
import com.nsf.bank.repository.UserRepository;
import org.hibernate.HibernateException;
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
	public String login(@RequestBody User user) {
		return userService.signin(user.getUsername(), user.getPassword());
	}

	@PutMapping("/api/update")
	public ResponseEntity update(@RequestBody User user){
		try {
			userRepository.save(user);
			return ResponseEntity.ok().body(user);
		} catch(HibernateException e) {
			return ResponseEntity.internalServerError().body(e.getMessage());
		} catch(Exception e) {
			return ResponseEntity.internalServerError().body(e.getMessage());
		}
	}

	@DeleteMapping("/api/delete/{id}")
	public ResponseEntity delete(@PathVariable(value="id") Integer id){
		userRepository.deleteById(id);
		return ResponseEntity.ok().body("Utilisateur supprimé");
	}
}
