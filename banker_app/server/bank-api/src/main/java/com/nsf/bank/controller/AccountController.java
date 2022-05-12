package com.nsf.bank.controller;

import com.nsf.bank.entity.Account;
import com.nsf.bank.entity.AccountBalance;
import com.nsf.bank.entity.AccountType;
import com.nsf.bank.entity.Customer;
import com.nsf.bank.repository.AccountRepository;
import com.nsf.bank.repository.CustomerRepository;
import com.nsf.bank.repository.AccountTypeRepository;
import com.nsf.bank.repository.AccountBalanceRepository;
import com.nsf.bank.service.HashidService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/accounts")
public class AccountController {
    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private AccountTypeRepository accountTypeRepository;

    @Autowired
    private AccountBalanceRepository accountBalanceRepository;

    @Autowired
    private HashidService hashidService;

    @RequestMapping("/")
    public ResponseEntity<List<Account>> getAll(){
        return ResponseEntity.ok().body(accountRepository.findAll());
    }

    @RequestMapping(value = "/customer/{id}", produces = "application/json")
    public ResponseEntity<List<Account>> getCustomerAccounts(@PathVariable(value="id") Integer id) {
        return ResponseEntity.ok().body(accountRepository.findAllByIdCustomer(id));
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public Account get(@PathVariable(value="id") Integer id){
        return accountRepository.getOne(id);
    }

    @PostMapping("/create/{customerId}")
    public ResponseEntity create(@PathVariable(value="customerId") int customerId, @RequestBody Account account){
        Customer customer = customerRepository.getOne(customerId);
        if(customer != null) {
            account.setCustomer(customer);
        }
        account.setHashid(hashidService.generateHashId());

        AccountType existingAccountType = accountTypeRepository.findAccountTypeWithName(account.getAccount_type().getName());

        if(existingAccountType != null) {
            account.setAccount_type(existingAccountType);
        }

        accountRepository.save(account);

        AccountBalance accountBalance = new AccountBalance();
        accountBalance.setBalance(account.getBalance());
        accountBalance.setAccount(account);

        accountBalanceRepository.save(accountBalance);

        return ResponseEntity.ok().body(account);
    }

    @PutMapping("/update")
    public Account update(@RequestBody Account account){
        return accountRepository.save(account);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        accountRepository.deleteById(id);
        return ResponseEntity.ok().body("Compte supprimé");
    }
}