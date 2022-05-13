package com.nsf.bank.entity;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "account_balances")
public class AccountBalance {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_account_balance")
    private int id;

    @OneToOne
    @JoinColumn(name = "id_account")
    private Account account;

    private float balance;

    @CreatedDate
    private Date created_at;

    @LastModifiedDate
    private Date updated_at;

    public AccountBalance() {}

    public AccountBalance(int id, Account account, float balance, Date created_at, Date updated_at) {
        super();
        this.id = id;
        this.account = account;
        this.balance = balance;
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

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
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

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }
}
