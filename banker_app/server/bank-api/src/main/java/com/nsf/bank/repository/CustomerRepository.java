package com.nsf.bank.repository;

import java.util.List;
import java.util.Optional;

import com.nsf.bank.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.nsf.bank.entity.Customer;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {
    @Query("select c from Customer c where c.banker.id = ?1")
    List<Customer> findAllByIdBanker(int id);

    @Query("select c from Customer c where c.hashid = ?1")
    Customer findCustomerByAccountNumber(String hashid);
}
