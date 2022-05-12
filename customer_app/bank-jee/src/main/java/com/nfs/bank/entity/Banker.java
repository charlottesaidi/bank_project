package com.nfs.bank.entity;
import javax.persistence.*;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "bankers")
public class Banker {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_banker")
    private int id;

    @OneToOne
    @JoinColumn(name = "id_user")
    private User user;

    private Date created_at;

    private Date updated_at;

    public Banker() {}

    public Banker(int id, User user) {
        super();
        this.id = id;
        this.user = user;
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
