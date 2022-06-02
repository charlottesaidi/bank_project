package com.nsf.bank.entity;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.Date;
import java.util.Locale;

@Entity
@Table(name = "account_types")
public class AccountType {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_account_type")
    private int id;

    @NotBlank(message="Ce champ est obligatoire")
    private String name;

    private float rate;

    @CreatedDate
    private Date created_at;

    @LastModifiedDate
    private Date updated_at;

    public AccountType() {}

    public AccountType(int id, String name, int rate, Date created_at, Date updated_at) {
        this.id = id;
        this.name = name;
        this.rate = rate;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name.toUpperCase(Locale.ROOT);
    }

    public float getRate() {
        return rate;
    }

    public void setRate(float rate) {
        this.rate = rate;
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
