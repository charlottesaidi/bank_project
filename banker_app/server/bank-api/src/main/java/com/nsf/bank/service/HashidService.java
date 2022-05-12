package com.nsf.bank.service;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Service;

@Service
public class HashidService {
    public String generateHashId() {
        String generatedHashId = RandomStringUtils.randomAlphanumeric(10);

        return generatedHashId.toUpperCase();
    }
}
