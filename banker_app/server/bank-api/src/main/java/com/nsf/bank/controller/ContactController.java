package com.nsf.bank.controller;

import com.fasterxml.jackson.databind.JsonMappingException;
import com.nsf.bank.entity.Contact;
import com.nsf.bank.entity.Transaction;
import com.nsf.bank.repository.ContactRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/contacts")
public class ContactController {
    @Autowired
    private ContactRepository contactRepository;

    @RequestMapping("/")
    public ResponseEntity getAll() {
        try {
            List<Contact> contacts = contactRepository.findAll();
            if(contacts.isEmpty()) {
                return ResponseEntity.ok().body("La boîte de réception est vide");
            } else {
                return ResponseEntity.ok().body(contacts);
            }
        } catch(Exception e) {
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="id") Integer id){
            Contact contact = contactRepository.getOne(id);
            return ResponseEntity.ok().body(contact);
    }
}
