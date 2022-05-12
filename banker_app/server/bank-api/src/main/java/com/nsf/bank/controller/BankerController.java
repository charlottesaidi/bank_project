package com.nsf.bank.controller;

import com.nsf.bank.entity.Customer;
import com.nsf.bank.entity.Role;
import com.nsf.bank.repository.CustomerRepository;
import com.nsf.bank.repository.UserRepository;
import com.nsf.bank.repository.BankerRepository;
import com.nsf.bank.service.HashidService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.nsf.bank.entity.User;
import com.nsf.bank.entity.Banker;

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

    @RequestMapping("/")
    public ResponseEntity<List<Banker>> getAll(){
        return ResponseEntity.ok().body(bankerRepository.findAll());
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public Banker get(@PathVariable(value="id") Integer id){
        return bankerRepository.getOne(id);
    }

    @PostMapping("/create")
    public ResponseEntity create(@RequestBody Banker banker){
        banker.setHashid(hashidService.generateHashId());

        User existingUser = userRepository.findUserWithEmail(banker.getUser().getEmail());
        if(existingUser == null) {
            User user = banker.getUser();
            user.setUsername(banker.getHashid());
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            List<Role> bankerRoles = new ArrayList<>();
            bankerRoles.add(Role.ROLE_ADMIN);
            user.setRole(bankerRoles);

            userRepository.save(user);

            bankerRepository.save(banker);

            return ResponseEntity.ok().body(banker);
        } else {
            return ResponseEntity.ok().body("Un utilisateur banquier existe déjà avec cet identifiant");
        }
    }

    @PutMapping("/update")
    public Banker update(@RequestBody Banker banker){
        return bankerRepository.save(banker);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        bankerRepository.deleteById(id);
        return ResponseEntity.ok().body("Banquier supprimé");
    }

    @GetMapping("/{id}/customers")
    public ResponseEntity<List<Customer>> getCustomers(@PathVariable(value="id") Integer id) {
        return ResponseEntity.ok().body(customerRepository.findAllByIdBanker(id));
    }
}
