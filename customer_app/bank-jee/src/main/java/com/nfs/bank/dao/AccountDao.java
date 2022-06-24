package com.nfs.bank.dao;
import com.nfs.bank.entity.Account;
import com.nfs.bank.entity.AccountType;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

public class AccountDao {
    private EntityManager em;

    public AccountDao(){
        em = PersistenceManager.getEmf().createEntityManager();
    }

    public List<Account> getAllEpargnes(Integer userid){
        Query query = em.createQuery("SELECT a FROM Account AS a WHERE a.customer.id = "+userid+" AND a.account_type.name = 'epargne'");
        return query.getResultList();
    }
    public List<Account> getAllCourants(Integer userid){
        Query query = em.createQuery("SELECT a FROM Account AS a WHERE a.customer.id = "+userid+" AND a.account_type.name = 'courant'");
        return query.getResultList();
    }

    public List<Account> getAll(Integer userid){
        Query query = em.createQuery("SELECT a FROM Account AS a WHERE a.customer.id = "+userid);
        return query.getResultList();
    }
}
