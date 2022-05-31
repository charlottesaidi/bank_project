package com.nsf.bank.repository;

import com.nsf.bank.entity.Account;
import com.nsf.bank.entity.ChangingRateDate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.awt.print.Pageable;
import java.util.List;

@Repository
public interface ChangingRateDateRepository extends JpaRepository<ChangingRateDate, Integer> {
    @Query("select c from ChangingRateDate c order by c.id desc")
    List<ChangingRateDate> findLastOne(Pageable pageable);
}
