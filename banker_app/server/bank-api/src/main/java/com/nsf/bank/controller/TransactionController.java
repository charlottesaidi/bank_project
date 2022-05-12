package com.nsf.bank.controller;

import com.nsf.bank.entity.*;
import com.nsf.bank.repository.AccountBalanceRepository;
import com.nsf.bank.repository.TransactionRepository;
import com.nsf.bank.repository.AccountRepository;
import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("api/transactions")
public class TransactionController {
    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private AccountBalanceRepository accountBalanceRepository;

    @RequestMapping("/")
    public ResponseEntity<List<Transaction>> getAll(){
        return ResponseEntity.ok().body(transactionRepository.findAll());
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public Transaction get(@PathVariable(value="id") Integer id){
        return transactionRepository.getOne(id);
    }

    @PostMapping("/createtest")
    public ResponseEntity createtest(@RequestBody Transaction transaction) {
        Account debitAccount = accountRepository.getOne(transaction.getDebit().getId());
        return ResponseEntity.ok().body(debitAccount.getAccount_balance());
    }

    @PostMapping("/create")
    public ResponseEntity create(@RequestBody Transaction transaction) {
        try {
            Account debitAccount = null;
            Account creditAccount = null;

            // on récupère les comptes débiteurs et/ou créditeurs
            if(transaction.getDebit() != null) {
                debitAccount = accountRepository.getOne(transaction.getDebit().getId());
            }
            if(transaction.getCredit() != null) {
                creditAccount = accountRepository.getOne(transaction.getCredit().getId());
            }

            // selon si les comptes sont renseignés, le type de transaction change (transfert entre deux comptes internes ou transactions extérieures(achat/provision))
            if (debitAccount != null && creditAccount != null) {
                List<TransactionType> transactionTypes = new ArrayList<>();
                transactionTypes.add(TransactionType.TRANSACTION_TYPE_TRANSFER);
                transaction.setDescription(transactionTypes);
            } else if (debitAccount != null) {
                List<TransactionType> transactionTypes = new ArrayList<>();
                transactionTypes.add(TransactionType.TRANSACTION_TYPE_DEBIT);
                transaction.setDescription(transactionTypes);
            } else if (creditAccount != null) {
                List<TransactionType> transactionTypes = new ArrayList<>();
                transactionTypes.add(TransactionType.TRANSACTION_TYPE_CREDIT);
                transaction.setDescription(transactionTypes);
            }

            // dans le cas d'un virement entre deux comptes
            if (transaction.getDescription().contains(TransactionType.TRANSACTION_TYPE_TRANSFER)) {
                // si le compte ne dépasse pas le découvert, la transaction passe
                if ((debitAccount.getBalance() - transaction.getAmount()) >= debitAccount.getOverdraft()) {
                    // on met à jour le solde du compte débiteur
                    debitAccount.setBalance(debitAccount.getBalance() - transaction.getAmount());
                    AccountBalance debitBalance = debitAccount.getAccount_balance();
                    debitBalance.setBalance(debitAccount.getBalance() - transaction.getAmount());
                    debitBalance.setAccount(debitAccount);
                    accountBalanceRepository.save(debitBalance);

                    // mise à jour du solde du compte crédité
                    creditAccount.setBalance(creditAccount.getBalance() + transaction.getAmount());
                    AccountBalance creditBalance = creditAccount.getAccount_balance();
                    creditBalance.setBalance(creditAccount.getBalance() + transaction.getAmount());
                    creditBalance.setAccount(creditAccount);
                    accountBalanceRepository.save(creditBalance);

                    // sauvegarde la transaction
                    transactionRepository.save(transaction);
                } else {
                    return ResponseEntity.ok().body("Le solde du compte débiteur dépasse le découvert autorisé");
                }
            }
            // dans le cas d'un paiement depuis un compte
            if (transaction.getDescription().contains(TransactionType.TRANSACTION_TYPE_DEBIT)) {
                // si le compte ne dépasse pas le découvert, la transaction passe
                if ((debitAccount.getBalance() - transaction.getAmount()) >= debitAccount.getOverdraft()) {
                    // on met à jour le solde du compte
                    debitAccount.setBalance(debitAccount.getBalance() - transaction.getAmount());
                    AccountBalance debitBalance = debitAccount.getAccount_balance();
                    debitBalance.setBalance(debitAccount.getBalance() - transaction.getAmount());
                    debitBalance.setAccount(debitAccount);
                    accountBalanceRepository.save(debitBalance);

                    // sauvegarde la transaction
                    transactionRepository.save(transaction);
                } else {
                    return ResponseEntity.ok().body("Le solde du compte dépasse le découvert autorisé");
                }
            }
            // dans le cas d'un crédit du compte (de l'argent arrive)
            if (transaction.getDescription().contains(TransactionType.TRANSACTION_TYPE_CREDIT)) {
                // mise à jour du solde du compte crédité
                creditAccount.setBalance(creditAccount.getBalance() + transaction.getAmount());
                AccountBalance creditBalance = creditAccount.getAccount_balance();
                creditBalance.setBalance(creditAccount.getBalance() + transaction.getAmount());
                creditBalance.setAccount(creditAccount);
                accountBalanceRepository.save(creditBalance);

                // sauvegarde la transaction
                transactionRepository.save(transaction);
            }
            return ResponseEntity.ok().body(transaction);
       } catch(HibernateException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
       } catch(NullPointerException e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
       } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
       }
    }

    @PutMapping("/update")
    public Transaction update(@RequestBody Transaction transaction){
        return transactionRepository.save(transaction);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Transaction> delete(@PathVariable(value="id") Integer id){
        transactionRepository.deleteById(id);
        return ResponseEntity.ok().body(null);
    }
}
