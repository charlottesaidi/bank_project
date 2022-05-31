package com.nsf.bank.controller;

import com.fasterxml.jackson.databind.JsonMappingException;
import com.nsf.bank.entity.*;
import com.nsf.bank.repository.AccountBalanceRepository;
import com.nsf.bank.repository.TransactionRepository;
import com.nsf.bank.repository.AccountRepository;
import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
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
    public ResponseEntity getAll(){
        List<Transaction> transactions = transactionRepository.findAll();
        if(transactions.isEmpty()) {
            return ResponseEntity.ok().body("Aucune transaction");
        } else {
            return ResponseEntity.ok().body(transactions);
        }
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="id") Integer id){
        Transaction transaction = transactionRepository.getOne(id);
        return ResponseEntity.ok().body(transaction);
    }

    @PostMapping("/create")
    public ResponseEntity create(@RequestBody Transaction transaction) {
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
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        // On récupère la transaction
        Transaction transaction = transactionRepository.getOne(id);
        Account debitAccount = null;
        Account creditAccount = null;

        // on récupère les comptes débiteur et/ou créditeur correspondants
        if(transaction.getDebit() != null) {
            debitAccount = accountRepository.getOne(transaction.getDebit().getId());
        }
        if(transaction.getCredit() != null) {
            creditAccount = accountRepository.getOne(transaction.getCredit().getId());
        }

        // dans le cas d'un virement entre deux comptes
        if (transaction.getDescription().contains(TransactionType.TRANSACTION_TYPE_TRANSFER)) {
            // on recrédite le compte débiteur
            debitAccount.setBalance(debitAccount.getBalance() + transaction.getAmount());
            AccountBalance debitBalance = debitAccount.getAccount_balance();
            debitBalance.setBalance(debitAccount.getBalance() + transaction.getAmount());
            debitBalance.setAccount(debitAccount);
            accountBalanceRepository.save(debitBalance);

            // on annule le crédit de l'autre compte et reset le solde
            creditAccount.setBalance(creditAccount.getBalance() - transaction.getAmount());
            AccountBalance creditBalance = creditAccount.getAccount_balance();
            creditBalance.setBalance(creditAccount.getBalance() - transaction.getAmount());
            creditBalance.setAccount(creditAccount);
            accountBalanceRepository.save(creditBalance);
        }
        // dans le cas d'un paiement depuis un compte
        if (transaction.getDescription().contains(TransactionType.TRANSACTION_TYPE_DEBIT)) {
            // on recrédite le compte
            debitAccount.setBalance(debitAccount.getBalance() + transaction.getAmount());
            AccountBalance debitBalance = debitAccount.getAccount_balance();
            debitBalance.setBalance(debitAccount.getBalance() + transaction.getAmount());
            debitBalance.setAccount(debitAccount);
            accountBalanceRepository.save(debitBalance);
        }
        // dans le cas d'un crédit du compte
        if (transaction.getDescription().contains(TransactionType.TRANSACTION_TYPE_CREDIT)) {
            // on annule le crédit de compte et reset le solde
            creditAccount.setBalance(creditAccount.getBalance() - transaction.getAmount());
            AccountBalance creditBalance = creditAccount.getAccount_balance();
            creditBalance.setBalance(creditAccount.getBalance() - transaction.getAmount());
            creditBalance.setAccount(creditAccount);
            accountBalanceRepository.save(creditBalance);
        }
        // On finit par supprimer la transaction
        transactionRepository.deleteById(id);
        return ResponseEntity.ok().body("Transaction annulée");
    }
}
