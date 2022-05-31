package com.nsf.bank.controller;

import com.nsf.bank.entity.*;
import com.nsf.bank.repository.CustomerRepository;
import com.nsf.bank.repository.UserRepository;
import com.nsf.bank.repository.BankerRepository;
import com.nsf.bank.service.HashidService;
import com.nsf.bank.service.UserService;
import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.client.HttpClientErrorException;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("api/bankers")
public class BankerController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BankerRepository bankerRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private HashidService hashidService;

    @Autowired
    private UserService userService;

    @RequestMapping("/")
    public ResponseEntity getAll() {
        List<Banker> bankers = bankerRepository.findAll();
        if(bankers.isEmpty()) {
            return ResponseEntity.ok().body("Aucun banquier n'a été créé pour le moment");
        } else {
            return ResponseEntity.ok().body(bankers);
        }
    }

    @RequestMapping(value = "/{hashid}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="hashid") String hashid) {
        Banker banker = bankerRepository.findBankerByAccountNumber(hashid);
        if(banker == null) {
            throw HttpClientErrorException.create(HttpStatus.NOT_FOUND, "Aucun banquier n'existe avec ce numéro", null, null, null);
        }
        return ResponseEntity.ok().body(banker);
    }

    @PostMapping("/create")
    public ResponseEntity create(@RequestBody Banker banker){
        banker.setHashid(hashidService.generateHashId());

        User user = banker.getUser();
        user.setUsername(banker.getHashid());
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        List<Role> bankerRoles = new ArrayList<>();
        bankerRoles.add(Role.ROLE_ADMIN);
        user.setRole(bankerRoles);

        userRepository.save(user);

        bankerRepository.save(banker);

        return ResponseEntity.ok().body(banker);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity update(@PathVariable(value="id") int id, @RequestBody Banker bankerDetails){
        Banker banker = bankerRepository.getOne(id);
        User userDetails = bankerDetails.getUser();

        User user = userService.updateUserDetails(userDetails, banker.getUser());

        if(userDetails.getPassword() != null) {
            user.setPassword(passwordEncoder.encode(userDetails.getPassword()));
        }

        userRepository.save(user);
        bankerRepository.save(banker);

        return ResponseEntity.ok().body(banker);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        bankerRepository.deleteById(id);
        return ResponseEntity.ok().body("Banquier supprimé");
    }

    @GetMapping("/{id}/customers")
    public ResponseEntity getCustomers(@PathVariable(value="id") Integer id) {
        List<Customer> bankerCustomers = customerRepository.findAllByIdBanker(id);
        if(bankerCustomers.isEmpty()) {
            return ResponseEntity.ok().body("Le portefeuille client est vide");
        } else {
            return ResponseEntity.ok().body(bankerCustomers);
        }
    }
}
