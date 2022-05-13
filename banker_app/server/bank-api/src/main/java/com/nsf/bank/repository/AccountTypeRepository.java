package com.nsf.bank.repository;

import com.nsf.bank.entity.AccountType;
import com.nsf.bank.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountTypeRepository extends JpaRepository<AccountType, Integer> {
    @Query("select a from AccountType a where a.name = ?1") //JPQL : on travaille sur les classe et non les tables
    AccountType findAccountTypeWithName(String name);
}
