package com.nfs.bank.entity;


import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "account_types")
public class AccountType {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_account_type")
    private int id;

    private String name;

    private int rate;

    private Date created_at;

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
        this.name = name;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }
}
