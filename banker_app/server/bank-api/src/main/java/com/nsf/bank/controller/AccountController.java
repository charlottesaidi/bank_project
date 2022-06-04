package com.nsf.bank.controller;

import com.nsf.bank.entity.*;
import com.nsf.bank.repository.*;
import com.nsf.bank.service.CardService;
import com.nsf.bank.service.HashidService;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;

import javax.validation.ConstraintViolationException;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@CrossOrigin(origins = "http://localhost:3000")
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
    private CardRepository cardRepository;

    @Autowired
    private HashidService hashidService;

    @Autowired
    private CardService cardService;

    @RequestMapping("/")
    public ResponseEntity getAll(){
        List<Account> accounts = accountRepository.findAll();
        if(accounts.isEmpty()) {
            return ResponseEntity.ok().body("Aucun compte bancaire n'a été créé pour le moment");
        } else {
            return ResponseEntity.ok().body(accounts);
        }
    }

    @RequestMapping(value = "/{hashid}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="hashid") String hashid){
        Account account = accountRepository.findAccountByAccountNumber(hashid);
        if(account == null) {
            throw HttpClientErrorException.create(HttpStatus.NOT_FOUND, "Aucun compte n'existe avec ce numéro", null, null, null);
        }
        return ResponseEntity.ok().body(account);
    }

    @PostMapping("/create/{customerId}")
    public ResponseEntity create(@PathVariable(value="customerId") int customerId, @RequestBody Account account) {
        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new HttpClientErrorException(HttpStatus.NOT_FOUND, "Le client n'existe pas"));

        account.setHashid(hashidService.generateAccountHashid(account.getAccount_type().getName()));
        account.setCustomer(customer);

        Card card = cardService.createAccountCard(account);
        Card existingCard = cardRepository.findBy(card.getNumber());

        if(null != existingCard) {
            return ResponseEntity.badRequest().body("Une carte bancaire est déjà enregistrée avec le numéro " + card.getNumber() + ". Recommencez la requête.");
        }

        AccountType existingAccountType = accountTypeRepository.findAccountTypeWithName(account.getAccount_type().getName());

        if (existingAccountType != null) {
            account.setAccount_type(existingAccountType);
        } else {
            throw HttpClientErrorException.create(HttpStatus.NOT_FOUND, "Ce type de compte n'existe pas", null, null, null);
        }

        accountRepository.save(account);
        cardRepository.save(card);

        AccountBalance accountBalance = new AccountBalance();
        accountBalance.setBalance(account.getBalance());
        accountBalance.setAccount(account);

        accountBalanceRepository.save(accountBalance);

        return ResponseEntity.ok().body(account);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity update(@PathVariable(value="id") int id, @RequestBody Account accountDetails, @RequestParam(required = false) Optional<Boolean> updateCard){
        Account account = accountRepository.getOne(id);

        if(updateCard.isPresent()) {
            Card card = cardService.updateAccountCardDetails(account);
            cardRepository.save(card);
        }

        if(accountDetails.getOverdraft() != 0) {
            account.setOverdraft(-accountDetails.getOverdraft());
        }
        if(accountDetails.getBalance() != 0) {
            List<Transaction> accountTransactions = transactionRepository.findAllByIdDebitAndIdCredit(account.getId());
            if(accountTransactions.isEmpty()) {
                account.setBalance(accountDetails.getBalance());
                account.getAccount_balance().setBalance(account.getBalance());
            } else {
                return ResponseEntity.badRequest().body("Le solde de ce compte n'est plus modifiable. Des transactions ont déjà été affectuées.");
            }
        }
        if(accountDetails.getAccount_type() != null) {
            AccountType existingAccountType = accountTypeRepository.findAccountTypeWithName(accountDetails.getAccount_type().getName());
            if (existingAccountType != null) {
                account.setAccount_type(existingAccountType);
            } else {
                throw HttpClientErrorException.create(HttpStatus.NOT_FOUND, "Ce type de compte n'existe pas", null, null, null);
            }
        }

        accountRepository.save(account);
        return ResponseEntity.ok().body(account);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        accountRepository.deleteById(id);
        return ResponseEntity.ok().body("Compte supprimé");
    }

    @GetMapping("/{id}/transactions")
    public ResponseEntity getTransactions(@PathVariable(value = "id") Integer id) {
        List<Transaction> transactions = transactionRepository.findAllByIdDebitAndIdCredit(id);

        return ResponseEntity.ok().body(transactions);
    }
}