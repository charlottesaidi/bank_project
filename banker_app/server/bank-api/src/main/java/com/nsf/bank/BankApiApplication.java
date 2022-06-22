package com.nsf.bank;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BankApiApplication {

    public static void main(String[] args) {
        // fixtures à run une fois. A commenter après le premier lancement de l'application :
        SpringApplication.run(BankApiApplication.class, args);
    }

}
