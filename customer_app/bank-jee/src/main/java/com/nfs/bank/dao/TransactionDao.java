package com.nfs.bank.dao;
import com.nfs.bank.entity.Transaction;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

public class TransactionDao {
    private EntityManager em;

    public TransactionDao(){
        em = PersistenceManager.getEmf().createEntityManager();
    }

    public List<Transaction> getAll(Integer accountid){
        Query query = em.createQuery("SELECT t FROM Transaction AS t WHERE MONTH(t.created_at) = MONTH(CURRENT_DATE()) AND (t.credit.id = :accountid OR t.debit.id = :accountid)");
        query.setParameter("accountid", accountid);
        return query.getResultList();
    }
}