package com.nsf.bank.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nsf.bank.entity.Role;
import com.nsf.bank.repository.UserRepository;
import com.nsf.bank.repository.CustomerRepository;
import com.nsf.bank.repository.BankerRepository;
import com.nsf.bank.service.HashidService;
import com.nsf.bank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.nsf.bank.entity.Customer;
import com.nsf.bank.entity.User;
import com.nsf.bank.entity.Banker;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("api/customers")
public class CustomerController {
    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BankerRepository bankerRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private HashidService hashidService;

    @RequestMapping("/")
    public ResponseEntity<List<Customer>> getAll(){
        return ResponseEntity.ok().body(customerRepository.findAll());
    }

    @RequestMapping(value = "/banker/{id}", produces = "application/json")
    public ResponseEntity<List<Customer>> getBankerCustomers(@PathVariable(value="id") Integer id) {
        return ResponseEntity.ok().body(customerRepository.findAllByIdBanker(id));
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public Customer get(@PathVariable(value="id") Integer id){
        return customerRepository.getOne(id);
    }

    @PostMapping("/create/{bankerId}")
    public ResponseEntity create(@PathVariable(value="bankerId") Integer bankerId, @RequestBody Customer customer) {
        customer.setHashid(hashidService.generateHashId());
        customer.setBanker(bankerRepository.getOne(bankerId));

        User existingUser = userRepository.findUserWithEmail(customer.getUser().getEmail());
        if(existingUser == null) {
            User user = customer.getUser();
            user.setUsername(customer.getHashid());
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            List<Role> roles = new ArrayList<>();
            roles.add(Role.ROLE_USER);
            user.setRole(roles);

            userRepository.save(user);
            customer.setUser(user);

            customerRepository.save(customer);

            return ResponseEntity.ok().body(customer);
        } else {
            return ResponseEntity.ok().body("Un utilisateur client existe déjà avec cet identifiant");
        }
    }

    @PutMapping("/update")
    public Customer update(@RequestBody Customer customer){
        return customerRepository.save(customer);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        customerRepository.deleteById(id);
        return ResponseEntity.ok().body("Client supprimé");
    }
}
