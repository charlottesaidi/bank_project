package com.nfs.bank.entity;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "transactions")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_transaction")
    private int id;

    @OneToOne
    @JoinColumn(name = "id_account_debit")
    private Account debit;

    @OneToOne
    @JoinColumn(name = "id_account_credit")
    private Account credit;

    private float amount;

    @Column(nullable = true)
    @Type(type="text")
    private String description;

    private Date created_at;

    private Date updated_at;

    public Transaction() {}

    public Transaction(int id, Account debit, Account credit, float amount, String description, Date created_at, Date updated_at) {
        super();
        this.id = id;
        this.debit = debit;
        this.credit = credit;
        this.amount = amount;
        this.description = description;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Account getDebit() {
        return debit;
    }

    public void setDebit(Account debit) {
        this.debit = debit;
    }

    public Account getCredit() {
        return credit;
    }

    public void setCredit(Account credit) {
        this.credit = credit;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
