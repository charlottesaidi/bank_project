package com.nsf.bank.entity;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "cards")
public class Card {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_card")
    private int id;

    @OneToOne
    @JoinColumn(name = "id_account")
    private Account account;

    @NotBlank(message="Ce champ est obligatoire")
    private String number;

    private Date validity_date;

    private String cvc;

    @CreatedDate
    private Date created_at;

    @LastModifiedDate
    private Date updated_at;

    public Card() {}

    public Card(int id, String number, Date validity_date, String cvc, Account account, Date created_at, Date updated_at) {
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

    public void setAccount(Account account) {
        this.account = account;
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

    public String getCvc() {
        if(cvc.length() < 3) {
            cvc = "0"+cvc;
        }
        return cvc;
    }

    public void setCvc(String cvc) {
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
