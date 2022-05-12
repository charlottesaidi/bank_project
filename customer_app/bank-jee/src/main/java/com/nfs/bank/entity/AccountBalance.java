package com.nfs.bank.entity;


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

    private Date created_at;

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
}
