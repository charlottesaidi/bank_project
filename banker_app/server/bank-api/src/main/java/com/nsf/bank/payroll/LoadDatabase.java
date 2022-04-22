package com.nsf.bank.payroll;

import com.nsf.bank.entity.Role;
import com.nsf.bank.entity.User;
import com.nsf.bank.repository.CustomerRepository;
import com.nsf.bank.repository.UserRepository;
import com.nsf.bank.service.JWTUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class LoadDatabase {
    private static final Logger log = LoggerFactory.getLogger(LoadDatabase.class);

    @Autowired
    private UserRepository userRepository;
    private CustomerRepository customerRepository;

    @Autowired
    private JWTUserService userService;

    @Bean
    CommandLineRunner initDatabase() {
        User customer = createUser("customer@example.fr", "customerpass", "Customer", "Test");
        User banker = createUser("banker@example.fr", "bankerpass", "Banker", "Test");
        User director = createUser("director@example.fr", "directorpass", "Director", "Test");

        List<Role> bankerRoles = new ArrayList<>();
        bankerRoles.add(Role.ROLE_ADMIN);
        banker.setRole(bankerRoles);

        List<Role> directorRoles = new ArrayList<>();
        bankerRoles.add(Role.ROLE_SUPER_ADMIN);
        director.setRole(bankerRoles);

        return args -> {
            log.info("Preloading " + userService.signup(customer));
            log.info("Preloading " + userService.signup(banker));
            log.info("Preloading " + userService.signup(director));
        };
    }

    public User createUser(String email, String password, String firstName, String lastName) {
        User user = new User();
        user.setPassword(password);
        user.setEmail(email);
        user.setFirst_name(firstName);
        user.setLast_name(lastName);
        user.setUsername(user.getEmail());

        return user;
    }
}

