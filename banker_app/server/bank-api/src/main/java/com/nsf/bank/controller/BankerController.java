package com.nsf.bank.controller;

import com.nsf.bank.entity.*;
import com.nsf.bank.repository.CustomerRepository;
import com.nsf.bank.repository.UserRepository;
import com.nsf.bank.repository.BankerRepository;
import com.nsf.bank.service.HashidService;
import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.client.HttpClientErrorException;

import java.util.ArrayList;
import java.util.Date;
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
    public ResponseEntity getAll() {
        try {
            List<Banker> bankers = bankerRepository.findAll();
            if(bankers == null) {
                return ResponseEntity.ok().body("Aucun banquier n'a été créé pour le moment");
            } else {
                return ResponseEntity.ok().body(bankers);
            }
        } catch(Exception e) {
            return ResponseEntity.ok().body(e.getMessage());
        }
    }

    @RequestMapping(value = "/{hashid}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="hashid") String hashid){
        try {
            Banker banker = bankerRepository.findBankerByAccountNumber(hashid);
            if(banker == null) {
                throw HttpClientErrorException.create(HttpStatus.NOT_FOUND, "Aucun banquier n'existe avec ce numéro", null, null, null);
            }
            return ResponseEntity.ok().body(banker);
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(NullPointerException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @PostMapping("/create")
    public ResponseEntity create(@RequestBody Banker banker){
        try {
            banker.setHashid(hashidService.generateHashId());

            User existingUser = userRepository.findUserWithEmail(banker.getUser().getEmail());

            if(existingUser != null) {
                throw new HibernateException("Un utilisateur existe déjà avec cet adresse email");
            }

            User user = banker.getUser();
            user.setUsername(banker.getHashid());
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            List<Role> bankerRoles = new ArrayList<>();
            bankerRoles.add(Role.ROLE_ADMIN);
            user.setRole(bankerRoles);

            userRepository.save(user);

            bankerRepository.save(banker);

            return ResponseEntity.ok().body(banker);
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @PutMapping("/update")
    public ResponseEntity update(@RequestBody Banker banker){
        try {
            banker.getUser().setUpdated_at(new Date());
            userRepository.save(banker.getUser());
            banker.setUpdated_at(new Date());
            bankerRepository.save(banker);

            return ResponseEntity.ok().body(banker);
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        try {
            bankerRepository.deleteById(id);
            return ResponseEntity.ok().body("Banquier supprimé");
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @GetMapping("/{id}/customers")
    public ResponseEntity getCustomers(@PathVariable(value="id") Integer id) {
        try {
            List<Customer> bankerCustomers = customerRepository.findAllByIdBanker(id);
            if(bankerCustomers == null) {
                return ResponseEntity.ok().body("Le portefeuille client est vide");
            } else {
                return ResponseEntity.ok().body(bankerCustomers);
            }
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.ok().body(e.getMessage());
        }
    }
}
