package com.nsf.bank.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.nsf.bank.entity.Banker;
@Repository
public interface BankerRepository extends JpaRepository<Banker, Integer> {

}
