package com.nsf.bank.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.nsf.bank.entity.Transaction;
@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Integer> {
    @Query("select t from Transaction t where t.credit.id = ?1")
    List<Transaction> findAllByIdCredit(int idCredit);

    @Query("select t from Transaction t where t.debit.id = ?1")
    List<Transaction> findAllByIdDebit(int idDebit);
}