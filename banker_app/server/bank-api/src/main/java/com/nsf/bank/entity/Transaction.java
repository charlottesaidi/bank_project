package com.nsf.bank.entity;

import org.hibernate.annotations.Type;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "transactions")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_transaction")
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_account_debit")
    private Account debit;

    @ManyToOne
    @JoinColumn(name = "id_account_credit")
    private Account credit;

    private float amount;

    private String label;

    @ElementCollection(fetch =  FetchType.EAGER)
    private List<TransactionType> description;

    @CreatedDate
    private Date created_at;

    @LastModifiedDate
    private Date updated_at;

    public Transaction() {}

    public Transaction(int id, Account debit, Account credit, float amount, String label, List<TransactionType> description, Date created_at, Date updated_at) {
        super();
        this.id = id;
        this.debit = debit;
        this.credit = credit;
        this.amount = amount;
        this.label = label;
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

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public List<TransactionType> getDescription() {
        return description;
    }

    public void setDescription(List<TransactionType> description) {
        this.description = description;
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
