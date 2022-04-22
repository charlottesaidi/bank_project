package com.nsf.bank.controller;

import com.nsf.bank.entity.User;
import com.nsf.bank.repository.CustomerRepository;
import com.nsf.bank.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.nsf.bank.entity.Customer;

import java.util.List;

@RestController
@RequestMapping("api/customers")
public class CustomerController {
    @Autowired
    private CustomerRepository customerRepository;

    @RequestMapping("/")
    public ResponseEntity<List<Customer>> getAll(){
        return ResponseEntity.ok().body(customerRepository.findAll());
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public Customer get(@PathVariable(value="id") Integer id){
        return customerRepository.getOne(id);
    }

    @PostMapping("/")
    public Customer create(@RequestBody Customer author){
        return customerRepository.save(author);
    }

    @PutMapping("/")
    public Customer update(@RequestBody Customer customer){
        return customerRepository.save(customer);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Customer> delete(@PathVariable(value="id") Integer id){
        customerRepository.deleteById(id);
        return ResponseEntity.ok().body(null);
    }
}
