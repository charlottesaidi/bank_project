package com.nsf.bank;

import org.apache.commons.lang3.RandomStringUtils;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.text.SimpleDateFormat;
import java.util.Date;

@SpringBootTest
class BankApiApplicationTests {

    @Test
    void contextLoads() {
        System.out.println(new Date("1991-01-01"));
    }

}
