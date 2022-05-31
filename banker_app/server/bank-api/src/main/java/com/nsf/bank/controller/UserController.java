package com.nsf.bank.controller;

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
	public ResponseEntity get(@PathVariable(value="id") Integer id) {
		User user = userRepository.getOne(id);
		return ResponseEntity.ok().body(user);
	}

	@PostMapping("/signin")
	public ResponseEntity login(@RequestBody User user) {
		return ResponseEntity.ok().body(userService.signin(user.getUsername(), user.getPassword()));
	}

	@DeleteMapping("/api/delete/{id}")
	public ResponseEntity delete(@PathVariable(value="id") Integer id){
		userRepository.deleteById(id);
		return ResponseEntity.ok().body("Utilisateur supprimé");
	}
}
