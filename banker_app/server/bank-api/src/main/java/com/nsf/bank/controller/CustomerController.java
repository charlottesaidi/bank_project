package com.nsf.bank.controller;

import com.fasterxml.jackson.databind.JsonMappingException;
import com.nsf.bank.entity.*;
import com.nsf.bank.repository.AccountRepository;
import com.nsf.bank.repository.UserRepository;
import com.nsf.bank.repository.CustomerRepository;
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
@RequestMapping("api/customers")
public class CustomerController {
    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BankerRepository bankerRepository;

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private HashidService hashidService;

    @RequestMapping("/")
    public ResponseEntity getAll() {
        try {
            List<Customer> customers = customerRepository.findAll();
            if(customers == null) {
                return ResponseEntity.ok().body("Aucun client n'est inscrit pour le moment");
            } else {
                return ResponseEntity.ok().body(customers);
            }
        } catch(Exception e) {
            return ResponseEntity.ok().body(e.getMessage());
        }
    }

    @RequestMapping(value = "/{hashid}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="hashid") String hashid) {
        try {
            Customer customer = customerRepository.findCustomerByAccountNumber(hashid);
            if(customer == null) {
                throw HttpClientErrorException.create(HttpStatus.NOT_FOUND, "Aucun client n'existe avec ce numéro", null, null, null);
            }
            return ResponseEntity.ok().body(customer);
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(NullPointerException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @PostMapping("/create/{bankerId}")
    public ResponseEntity create(@PathVariable(value="bankerId") Integer bankerId, @RequestBody Customer customer) {
        try {
            customer.setHashid(hashidService.generateHashId());
            customer.setBanker(bankerRepository.getOne(bankerId));

            User existingUser = userRepository.findUserWithEmail(customer.getUser().getEmail());

            if(existingUser != null) {
                throw new HibernateException("Un utilisateur existe déjà avec cet adresse email");
            }

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
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @PutMapping("/update")
    public ResponseEntity update(@RequestBody Customer customer) {
        try {
            userRepository.save(customer.getUser());
            customerRepository.save(customer);

            return ResponseEntity.ok().body(customer);
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        try {
            customerRepository.deleteById(id);
            return ResponseEntity.ok().body("Client supprimé");
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @GetMapping("/{id}/accounts")
    public ResponseEntity getAccounts(@PathVariable(value="id") Integer id) {
        try {
            List<Account> customerAccounts = accountRepository.findAllByIdCustomer(id);
            if(customerAccounts.isEmpty()) {
                return ResponseEntity.ok().body("Ce client ne possède aucun compte");
            } else {
                return ResponseEntity.ok().body(customerAccounts);
            }
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.ok().body(e.getMessage());
        }
    }
}
