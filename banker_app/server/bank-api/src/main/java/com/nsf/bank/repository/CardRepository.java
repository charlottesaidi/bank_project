package com.nsf.bank.repository;

import com.nsf.bank.entity.Account;
import com.nsf.bank.entity.Card;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CardRepository extends JpaRepository<Card, String> {
    @Query("select c from Card c where c.number = ?1")
    Card findBy(String number);
}
