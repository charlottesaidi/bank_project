package com.nfs.bank.dao;

import com.nfs.bank.entity.User;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

public class UserDao {
    private EntityManager em;

    public UserDao(){
        em = PersistenceManager.getEmf().createEntityManager();
    }

    public User create(User u){
        try {
            em.getTransaction().begin();
            em.persist(u);
            em.getTransaction().commit();
        }catch(Exception e){
            em.getTransaction().rollback();
        }
        return u;
    }

    public User get(int id){
        return em.find(User.class, id);
    }

    public List<User> checkUser(String username, String password){
        Query query = em.createQuery("SELECT u FROM User AS u WHERE username = :username AND password = :password");// le nom de la classe
        query.setParameter("username", username);
        query.setParameter("password", password);
        return query.getResultList();
    }

    public List<User> getAll(){
        Query query = em.createQuery("SELECT u FROM User AS u");// le nom de la classe
        return query.getResultList();
    }
}