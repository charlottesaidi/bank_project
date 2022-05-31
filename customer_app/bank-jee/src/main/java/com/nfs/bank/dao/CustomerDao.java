package com.nfs.bank.dao;

import com.nfs.bank.entity.Customer;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

public class CustomerDao {
    private EntityManager em;

    public CustomerDao(){
        em = PersistenceManager.getEmf().createEntityManager();
    }

    public Customer create(Customer c){
        try {
            em.getTransaction().begin();
            em.persist(c);
            em.getTransaction().commit();
        }catch(Exception e){
            em.getTransaction().rollback();
        }
        return c;
    }

    public Customer get(int id){
        return em.find(Customer.class, id);
    }

    public List<Customer> getAll(){
        Query query = em.createQuery("SELECT c FROM Customer AS c");// le nom de la classe
        return query.getResultList();
    }
}