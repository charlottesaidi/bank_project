package com.nsf.bank.controller;

import com.nsf.bank.entity.AccountType;
import com.nsf.bank.repository.AccountTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Locale;

@RestController
@CrossOrigin(origins = "http://localhost:3000")
@RequestMapping("api/account-types")
public class AccountTypeController {
    @Autowired
    AccountTypeRepository accountTypeRepository;

    @RequestMapping("/")
    public ResponseEntity getAll() {
        List<AccountType> accountTypes = accountTypeRepository.findAll();
        if(accountTypes.isEmpty()) {
            return ResponseEntity.ok().body("Aucun type de compte n'a été entré pour le moment");
        } else {
            return ResponseEntity.ok().body(accountTypes);
        }
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="id") Integer id){
        AccountType accountType = accountTypeRepository.getOne(id);
        return ResponseEntity.ok().body(accountType);
    }

    @PostMapping("/create")
    public ResponseEntity create(@RequestBody AccountType accountType) {
        String name = accountType.getName();
        float rate = accountType.getRate();

        if(name.toLowerCase(Locale.ROOT).contains("courant")) {
            if(rate > 0) {
                return ResponseEntity.badRequest().body("Les comptes courants doivent avoir un taux à 0");
            }
        }

        accountTypeRepository.save(accountType);
        return ResponseEntity.ok().body(accountType);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity update(@PathVariable(value="id") Integer id, @RequestBody  AccountType accountTypeValues){
        AccountType accountType = accountTypeRepository.getOne(id);
        String name = accountTypeValues.getName();
        float rate = accountTypeValues.getRate();

        if(name != null) {
            if(name.toLowerCase(Locale.ROOT).contains("courant")) {
                if(accountType.getRate() > 0) {
                    accountType.setRate(0);
                }
            }
            accountType.setName(name);
        }
        if(rate != 0) {
            if(name != null && name.toLowerCase(Locale.ROOT).contains("courant")) {
                return ResponseEntity.badRequest().body("Les comptes courants doivent avoir un taux à 0");
            } else {
                accountType.setRate(rate);
            }
        }

        accountTypeRepository.save(accountType);
        return ResponseEntity.ok().body(accountType);
    }
}
