package com.nsf.bank.repository;

import java.util.List;
import java.util.Optional;

import com.nsf.bank.entity.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {
    @Query("select a from Account a where a.customer.id = ?1")
    List<Account> findAllByIdCustomer(int id);

    @Query("select a from Account a where a.hashid = ?1")
    Account findAccountByAccountNumber(String hashid);

    @Query("select a from Account a JOIN a.customer c JOIN c.banker b where b.hashid = ?1")
    List<Account> findAllAccountsByBankerClients(String hashid);
}
