package com.nsf.bank.entity;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "cards")
public class Card {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_account")
    private int id;

    private String number;

    private Date validity_date;

    private int cvc;

    @OneToOne
    @JoinColumn(name = "id_account")
    private Account account;

    @CreatedDate
    private Date created_at;

    @LastModifiedDate
    private Date updated_at;

    public Card() {}

    public Card(int id, String number, Date validity_date, int cvc, Account account, Date created_at, Date updated_at) {
        this.id = id;
        this.number = number;
        this.validity_date = validity_date;
        this.cvc = cvc;
        this.account = account;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public Date getValidity_date() {
        return validity_date;
    }

    public void setValidity_date(Date validity_date) {
        this.validity_date = validity_date;
    }

    public int getCvc() {
        return cvc;
    }

    public void setCvc(int cvc) {
        this.cvc = cvc;
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
