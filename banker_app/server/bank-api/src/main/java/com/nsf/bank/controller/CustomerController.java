package com.nsf.bank.controller;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import com.nsf.bank.entity.*;
import com.nsf.bank.repository.AccountRepository;
import com.nsf.bank.repository.UserRepository;
import com.nsf.bank.repository.CustomerRepository;
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

    @Autowired
    private UserService userService;

    @RequestMapping("/")
    public ResponseEntity getAll() {
        List<Customer> customers = customerRepository.findAll();
        if(customers.isEmpty()) {
            return ResponseEntity.ok().body("Aucun client n'est inscrit pour le moment");
        } else {
            return ResponseEntity.ok().body(customers);
        }
    }

    @RequestMapping(value = "/{hashid}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="hashid") String hashid) {
        Customer customer = customerRepository.findCustomerByAccountNumber(hashid);
        if(customer == null) {
            throw HttpClientErrorException.create(HttpStatus.NOT_FOUND, "Aucun client n'existe avec ce numéro", null, null, null);
        }
        return ResponseEntity.ok().body(customer);
    }

    @PostMapping("/create/{bankerId}")
    public ResponseEntity create(@PathVariable(value="bankerId") Integer bankerId, @RequestBody Customer customer) throws MySQLIntegrityConstraintViolationException {
        customer.setHashid(hashidService.generateHashId());
        customer.setBanker(bankerRepository.getOne(bankerId));

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
    }

    @PutMapping("/update/{id}")
    public ResponseEntity update(@PathVariable(value="id") int id, @RequestBody Customer customerDetails) {
        Customer customer = customerRepository.getOne(id);
        User userDetails = customerDetails.getUser();

        User user = userService.updateUserDetails(userDetails, customer.getUser());

        if(userDetails.getPassword() != null) {
            user.setPassword(passwordEncoder.encode(userDetails.getPassword()));
        }

        userRepository.save(user);
        customerRepository.save(customer);

        return ResponseEntity.ok().body(customer);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        customerRepository.deleteById(id);
        return ResponseEntity.ok().body("Client supprimé");
    }

    @GetMapping("/{id}/accounts")
    public ResponseEntity getAccounts(@PathVariable(value="id") Integer id) {
        List<Account> customerAccounts = accountRepository.findAllByIdCustomer(id);
        if(customerAccounts.isEmpty()) {
            return ResponseEntity.ok().body("Ce client ne possède aucun compte");
        } else {
            return ResponseEntity.ok().body(customerAccounts);
        }
    }
}
