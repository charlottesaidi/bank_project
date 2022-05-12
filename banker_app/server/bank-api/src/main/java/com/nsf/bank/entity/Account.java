package com.nsf.bank.entity;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "accounts")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_account")
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_customer")
    private Customer customer;

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "id_account_type")
    private AccountType account_type;

    @OneToOne(mappedBy = "account", cascade = CascadeType.ALL, orphanRemoval = true)
    private AccountBalance account_balance;

    private String hashid;

    private float balance;

    private float overdraft;

    @OneToMany(orphanRemoval = true, mappedBy = "debit")
    private List<Transaction> transactionDebits;

    @OneToMany(orphanRemoval = true, mappedBy = "credit")
    private List<Transaction> transactionCredits;

    @CreatedDate
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Date created_at;

    @LastModifiedDate
    private Date updated_at;

    public Account() {}

    public Account(int id, Customer customer, AccountType account_type, AccountBalance account_balance, String hashid, float balance, float overdraft, Date created_at, Date updated_at) {
        super();
        this.id = id;
        this.customer = customer;
        this.account_balance = account_balance;
        this.account_type = account_type;
        this.hashid = hashid;
        this.balance = balance;
        this.overdraft = overdraft;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public AccountType getAccount_type() {
        return account_type;
    }

    public void setAccount_type(AccountType account_type) {
        this.account_type = account_type;
    }

    public AccountBalance getAccount_balance() {
        return account_balance;
    }

    public void setAccount_balance(AccountBalance account_balance) {
        this.account_balance = account_balance;
    }

    public void setTransactionDebits(List<Transaction> transactionDebits) {
        this.transactionDebits = transactionDebits;
    }

    public void setTransactionCredits(List<Transaction> transactionCredits) {
        this.transactionCredits = transactionCredits;
    }

    public String getHashid() {
        return hashid;
    }

    public void setHashid(String hashid) {
        this.hashid = hashid;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }

    public float getOverdraft() {
        return overdraft;
    }

    public void setOverdraft(float overdraft) {
        this.overdraft = -overdraft;
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
