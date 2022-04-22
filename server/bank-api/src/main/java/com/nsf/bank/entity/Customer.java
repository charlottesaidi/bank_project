package com.nsf.bank.entity;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "customers")
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_customer")
    private int id;

    @OneToOne
    @JoinColumn(name = "id_user")
    private User user;

    @ManyToOne
    @JoinColumn(name = "id_banker")
    private Banker banker;

    private long hashid;

    private String document_type;

    private Date document_date;

    @CreatedDate
    private Date created_at;

    @LastModifiedDate
    private Date updated_at;

    public Customer() {}

    public Customer(int id, User user, Banker banker, long hashid, String document_type, Date document_date, Date created_at, Date updated_at) {
        super();
        this.id = id;
        this.user = user;
        this.banker = banker;
        this.hashid = hashid;
        this.document_type = document_type;
        this.document_date = document_date;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Banker getBanker() {
        return banker;
    }

    public void setBanker(Banker banker) {
        this.banker = banker;
    }

    public long getHashid() {
        return hashid;
    }

    public void setHashid(long hashid) {
        this.hashid = hashid;
    }

    public String getDocument_type() {
        return document_type;
    }

    public void setDocument_type(String document_type) {
        this.document_type = document_type;
    }

    public Date getDocument_date() {
        return document_date;
    }

    public void setDocument_date(Date document_date) {
        this.document_date = document_date;
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
