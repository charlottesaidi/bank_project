package com.nsf.bank.payroll;

import com.nsf.bank.entity.Role;
import com.nsf.bank.entity.User;
import com.nsf.bank.entity.Customer;
import com.nsf.bank.entity.Banker;
import com.nsf.bank.repository.CustomerRepository;
import com.nsf.bank.repository.BankerRepository;
import com.nsf.bank.repository.UserRepository;
import com.nsf.bank.service.HashidService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Configuration
public class LoadDatabase {
    private static final Logger log = LoggerFactory.getLogger(LoadDatabase.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private BankerRepository bankerRepository;

    @Autowired
    private HashidService hashidService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    CommandLineRunner initDatabase() throws ParseException {
        User customer = createUser("customer@example.fr", "customerpass", "Customer", "Test");
        Customer userCustomer = new Customer();

        User banker = createUser("banker@example.fr", "bankerpass", "Banker", "Test");
        Banker userBanker = new Banker();

        User director = createUser("director@example.fr", "directorpass", "Director", "Test");
        Banker userDirector = new Banker();

        List<Role> bankerRoles = new ArrayList<>();
        bankerRoles.add(Role.ROLE_ADMIN);
        banker.setRole(bankerRoles);

        List<Role> directorRoles = new ArrayList<>();
        directorRoles.add(Role.ROLE_SUPER_ADMIN);
        director.setRole(directorRoles);

        List<Role> userRoles = new ArrayList<>();
        userRoles.add(Role.ROLE_USER);
        customer.setRole(userRoles);

        User existingCustomer = userRepository.findUserWithEmail("customer@example.fr");
        User existingBanker = userRepository.findUserWithEmail("banker@example.fr");
        User existingDirector = userRepository.findUserWithEmail("director@example.fr");
        int count = 0;

        if(existingBanker == null) {
            userBanker.setHashid(hashidService.generateHashId());
            banker.setUsername(userBanker.getHashid());
            userRepository.save(banker);
            userBanker.setUser(banker);
            bankerRepository.save(userBanker);
            count++;
        }
        if(existingCustomer == null) {
            userCustomer.setBanker(userBanker);
            userCustomer.setHashid(hashidService.generateHashId());
            customer.setUsername(userCustomer.getHashid());
            userRepository.save(customer);
            userCustomer.setUser(customer);
            userCustomer.setDocument_type("attestation_domicile");
            customerRepository.save(userCustomer);
            count++;
        }
        if(existingDirector == null) {
            userDirector.setHashid(hashidService.generateHashId());
            director.setUsername(userDirector.getHashid());
            userRepository.save(director);
            userDirector.setUser(director);
            bankerRepository.save(userDirector);
            count++;
        }

        int finalCount = count;
        return args -> {
            log.info("Preloading " + finalCount + " utilisateur.s inséré.s");
        };
    }

    public User createUser(String email, String password, String firstName, String lastName) throws ParseException {
        User user = new User();
        user.setPassword(passwordEncoder.encode(password));
        user.setEmail(email);
        user.setFirst_name(firstName);
        user.setLast_name(lastName);
        user.setBirthdate(new SimpleDateFormat("yyyy-MM-dd").parse("1990-01-01"));
        user.setPhone("0600000000");
        user.setAddress_street("rue test");
        user.setAddress_zipcode("76000");
        user.setAddress_city("Rouen");
        user.setAddress_country("France");

        return user;
    }
}

