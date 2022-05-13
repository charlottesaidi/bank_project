package com.nsf.bank.controller;

import com.nsf.bank.entity.*;
import com.nsf.bank.repository.*;
import com.nsf.bank.service.HashidService;
import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;

import java.lang.reflect.Array;
import java.util.Date;
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
    public ResponseEntity getAll(){
        try {
            List<Account> accounts = accountRepository.findAll();
            if(accounts == null) {
                return ResponseEntity.ok().body("Aucun compte bancaire n'a été créé pour le moment");
            } else {
                return ResponseEntity.ok().body(accounts);
            }
        } catch(Exception e) {
            return ResponseEntity.ok().body(e.getMessage());
        }
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="id") Integer id){
        try {
            Account account = accountRepository.getOne(id);
            if(account == null) {
                throw HttpClientErrorException.create(HttpStatus.NOT_FOUND, "Aucun banquier n'existe avec ce numéro", null, null, null);
            }
            return ResponseEntity.ok().body(account);
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(NullPointerException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @PostMapping("/create/{customerId}")
    public ResponseEntity create(@PathVariable(value="customerId") int customerId, @RequestBody Account account){
        try {
            Customer customer = customerRepository.getOne(customerId);
            if (customer == null) {
                throw new HibernateException("Aucun client n'a été trouvé sous ce numéro");
            }
            account.setHashid(hashidService.generateHashId());

            AccountType existingAccountType = accountTypeRepository.findAccountTypeWithName(account.getAccount_type().getName());

            if (existingAccountType != null) {
                account.setAccount_type(existingAccountType);
            }

            accountRepository.save(account);

            AccountBalance accountBalance = new AccountBalance();
            accountBalance.setBalance(account.getBalance());
            accountBalance.setAccount(account);

            accountBalanceRepository.save(accountBalance);

            return ResponseEntity.ok().body(account);
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @PutMapping("/update")
    public ResponseEntity update(@RequestBody Account account){
        try {
            accountRepository.save(account);
            return ResponseEntity.ok().body(account);
        } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
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