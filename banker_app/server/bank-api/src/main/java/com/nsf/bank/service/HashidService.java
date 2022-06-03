package com.nsf.bank.service;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Service;

@Service
public class HashidService {
    public String generateHashId() {
        String generatedHashId = RandomStringUtils.random(10, false, true);

        return generatedHashId;
    }

    public String generateAccountHashid(String type) {
        String generatedHashid = "ACC"+RandomStringUtils.random(7, false, true);

        if(type.contains("CPT_COURANT")) {
            generatedHashid = "CUR"+RandomStringUtils.random(7, false, true);
        }
        if(type.contains("LDD")) {
            generatedHashid = "LDD"+RandomStringUtils.random(7, false, true);
        }
        if(type.contains("LIVRET")) {
            generatedHashid = "LVA"+RandomStringUtils.random(7, false, true);
        }

        return generatedHashid;
    }
}
