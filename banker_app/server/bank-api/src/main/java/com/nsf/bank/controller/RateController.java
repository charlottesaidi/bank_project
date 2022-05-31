package com.nsf.bank.controller;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import com.nsf.bank.entity.*;
import com.nsf.bank.repository.ChangingRateDateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("api/rate-dates")
public class RateController {
    @Autowired
    private ChangingRateDateRepository changingRateDateRepository;

    @RequestMapping(value = "/", produces = "application/json")
    public ResponseEntity getAll(){
        List<ChangingRateDate> rateDates = changingRateDateRepository.findAll();
        return ResponseEntity.ok().body(rateDates);
    }

    @RequestMapping(value = "/{id}", produces = "application/json")
    public ResponseEntity get(@PathVariable(value="id") Integer id){
        ChangingRateDate rateDate = changingRateDateRepository.getOne(id);
        return ResponseEntity.ok().body(rateDate);
    }

    @PostMapping("/create")
    public ResponseEntity create(@RequestBody ChangingRateDate rateDate) {
        changingRateDateRepository.save(rateDate);
        return ResponseEntity.ok().body(rateDate);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity update(@PathVariable(value="id") Integer id, @RequestBody ChangingRateDate rateDateValues){
        ChangingRateDate rateDate = changingRateDateRepository.getOne(id);
        rateDate.setStart_date(rateDateValues.getStart_date());
        rateDate.setEnd_date(rateDateValues.getEnd_date());
        changingRateDateRepository.save(rateDate);
        return ResponseEntity.ok().body(rateDate);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity delete(@PathVariable(value="id") Integer id){
        changingRateDateRepository.deleteById(id);
        return ResponseEntity.ok().body("Période supprimée");
    }
}
