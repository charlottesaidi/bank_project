package com.nsf.bank.entity;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "contacts")
public class Contact {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_account")
    private int id;

    private String subject;

    @Column(columnDefinition = "TEXT")
    private String message;

    private String email;

    @ManyToOne
    @JoinColumn(name = "id_customer", nullable = true)
    private Customer customer;

    @CreatedDate
    private Date created_at;

    @LastModifiedDate
    private Date updated_at;

    public Contact() {}

    public Contact(int id, String subject, String message, String email, Customer customer, Date created_at, Date updated_at) {
        this.id = id;
        this.subject = subject;
        this.message = message;
        this.email = email;
        this.customer = customer;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Date getCreated_at() {
        return created_at;
    }

    @PrePersist
    public void setCreated_at() {
        if(this.created_at == null) {
            this.created_at = new Date();
        }
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    @PreUpdate
    public void setUpdated_at() {
        if(this.updated_at == null) {
            this.updated_at = new Date();
        }
    }
}
