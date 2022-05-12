package com.nsf.bank.controller;

import com.nsf.bank.entity.*;
import com.nsf.bank.repository.*;
import com.nsf.bank.service.HashidService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Array;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
    private TransactionRepository transactionRepository;

    @Autowired
    private HashidService hashidService;

    @RequestMapping("/")
    public ResponseEntity<List<Account>> getAll(){
        return ResponseEntity.ok().body(accountRepository.findAll());
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

    @GetMapping("/{id}/transactions")
    public ResponseEntity getTransactions(@PathVariable(value = "id") Integer id) {
//      Récupérer toutes les transactions liées à ce compte (débits ET crédits de compte)
        List<Transaction> debits = transactionRepository.findAllByIdDebit(id);
        List<Transaction> credits = transactionRepository.findAllByIdCredit(id);
//      Merge les deux listes de transactions en une seule
        List<Transaction> transactions = Stream.concat(debits.stream(), credits.stream())
                .collect(Collectors.toList());
//      Todo: trier les transactions par période ? (mois, année...)

        return ResponseEntity.ok().body(transactions);
    }
}