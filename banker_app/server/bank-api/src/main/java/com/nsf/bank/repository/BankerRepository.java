package com.nsf.bank.repository;

import java.util.Optional;

import com.nsf.bank.entity.Banker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface BankerRepository extends JpaRepository<Banker, Integer> {

}
