package com.nsf.bank.payroll;

import com.github.javafaker.Faker;
import com.nsf.bank.entity.*;
import com.nsf.bank.repository.*;
import com.nsf.bank.service.CardService;
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
import java.util.Locale;

@Configuration
public class LoadDatabase {
    private static final Logger log = LoggerFactory.getLogger(LoadDatabase.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private AccountTypeRepository accountTypeRepository;

    @Autowired
    private BankerRepository bankerRepository;

    @Autowired
    private CardRepository cardRepository;

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private AccountBalanceRepository accountBalanceRepository;

    @Autowired
    private HashidService hashidService;

    @Autowired
    private CardService cardService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    CommandLineRunner initDatabase() throws ParseException {
        int usersCount = createUsers();
        int accountTypesCount = createAccountTypes();

        return args -> {
            log.info("Loading fixtures : " + usersCount + " utilisateur.s inséré.s");
            log.info("Loading fixtures : " + accountTypesCount + " type.s de compte inséré.s");
        };
    }

    public User createUser(String email, String password, String firstName, String lastName) throws ParseException {
        Faker faker = new Faker(new Locale("fr-FR"));
        User user = new User();
        user.setPassword(passwordEncoder.encode(password));
        user.setEmail(email);
        user.setFirst_name(firstName);
        user.setLast_name(lastName);
        user.setBirthdate(new SimpleDateFormat("yyyy-MM-dd").parse("1990-01-01"));
        user.setPhone("0600000000");
        user.setAddress_street(faker.address().buildingNumber() + " " + faker.address().streetName());
        user.setAddress_zipcode(faker.address().zipCode());
        user.setAddress_city(faker.address().city());
        user.setAddress_country("France");

        return user;
    }

    public int createUsers() throws ParseException {
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

        User existingUserCustomer = userRepository.findUserWithEmail("customer@example.fr");
        User existingUserBanker = userRepository.findUserWithEmail("banker@example.fr");
        User existingUserDirector = userRepository.findUserWithEmail("director@example.fr");
        int count = 0;

        if(existingUserBanker == null) {
            userBanker.setHashid(hashidService.generateHashId());
            banker.setUsername(userBanker.getHashid());
            userRepository.save(banker);
            userBanker.setUser(banker);
            bankerRepository.save(userBanker);
            count++;
        } else {
            Banker bankerAlreadyExist = bankerRepository.findBankerByAccountNumber(existingUserBanker.getUsername());
            if(bankerAlreadyExist == null) {
                userBanker.setHashid(hashidService.generateHashId());
                userBanker.setUser(existingUserBanker);
                bankerRepository.save(userBanker);
            } else {
                userBanker = bankerAlreadyExist;
            }
        }

        if(existingUserCustomer == null) {
            userCustomer.setBanker(userBanker);
            userCustomer.setHashid(hashidService.generateHashId());
            customer.setUsername(userCustomer.getHashid());
            userRepository.save(customer);
            userCustomer.setUser(customer);
            List<String> documents = new ArrayList<>();
            documents.add("attestation_domicile");
            documents.add("piece_id");
            documents.add("avis_impots");
            userCustomer.setDocument_type(documents);
            customerRepository.save(userCustomer);
            count++;
        } else {
            Customer customerAlreadyExists = customerRepository.findCustomerByAccountNumber(existingUserCustomer.getUsername());
            if(customerAlreadyExists == null) {
                userCustomer.setBanker(userBanker);
                userCustomer.setUser(existingUserCustomer);
                userCustomer.setHashid(hashidService.generateHashId());
                List<String> documents = new ArrayList<>();
                documents.add("attestation_domicile");
                documents.add("piece_id");
                documents.add("avis_impots");
                userCustomer.setDocument_type(documents);
                customerRepository.save(userCustomer);
            } else {
                userCustomer = customerAlreadyExists;
            }
        }

        if(existingUserDirector == null) {
            userDirector.setHashid(hashidService.generateHashId());
            director.setUsername(userDirector.getHashid());
            userRepository.save(director);
            userDirector.setUser(director);
            bankerRepository.save(userDirector);
            count++;
        } else {
            Banker directorAlreadyExist = bankerRepository.findBankerByAccountNumber(existingUserDirector.getUsername());
            if(directorAlreadyExist == null) {
                userDirector.setHashid(hashidService.generateHashId());
                userDirector.setUser(existingUserDirector);
                bankerRepository.save(userDirector);
            }
        }

        createFakeCustomers(userBanker, count);

        int finalCount = count;

        return finalCount;
    }

    public void createFakeCustomers(Banker userBanker, int count) throws ParseException {
        Faker faker = new Faker(new Locale("fr-FR"));

        AccountType accountType = accountTypeRepository.findAccountTypeWithName("CPT_COURANT");

        for (int i = 0; i < 30; i++) {
            User newUser = createUser(faker.name().username()+"@examplemail.fr", "customerpass", faker.name().firstName(), faker.name().lastName());
            Customer newUserCustomer = new Customer();

            List<Role> newUserRoles = new ArrayList<>();
            newUserRoles.add(Role.ROLE_USER);
            newUser.setRole(newUserRoles);

            newUserCustomer.setBanker(userBanker);
            newUserCustomer.setHashid(hashidService.generateHashId());
            newUser.setUsername(newUserCustomer.getHashid());
            userRepository.save(newUser);
            newUserCustomer.setUser(newUser);
            List<String> documents = new ArrayList<>();
            documents.add("attestation_domicile");
            documents.add("piece_id");
            documents.add("avis_impots");
            newUserCustomer.setDocument_type(documents);
            customerRepository.save(newUserCustomer);

            Account account = new Account();
            account.setHashid(hashidService.generateAccountHashid("CPT_COURANT"));
            account.setBalance(1000+i);
            account.setOverdraft(100+i);
            account.setCustomer(newUserCustomer);

            account.setAccount_type(accountType);

            Card card = cardService.createAccountCard(account);

            accountRepository.save(account);
            cardRepository.save(card);

            AccountBalance accountBalance = new AccountBalance();
            accountBalance.setBalance(account.getBalance());
            accountBalance.setAccount(account);

            accountBalanceRepository.save(accountBalance);

            count++;
        }
    }

    public AccountType createAccountType(String type, float rate) {
        AccountType accountType = new AccountType();
        accountType.setName(type);
        accountType.setRate(rate);
        return accountType;
    }

    public int createAccountTypes() {
        int count = 0;

        AccountType ccp = createAccountType("cpt_courant", 0);
        AccountType ldd = createAccountType("livret_developpement_durable", (float) 0.6);
        AccountType livret = createAccountType("livret_a", (float) 0.3);

        AccountType existingCcp = accountTypeRepository.findAccountTypeWithName(ccp.getName());
        AccountType existingLdd = accountTypeRepository.findAccountTypeWithName(ldd.getName());
        AccountType existingLivret = accountTypeRepository.findAccountTypeWithName(livret.getName());

        if(existingCcp == null) {
            accountTypeRepository.save(ccp);
            count++;
        }
        if(existingLdd == null) {
            accountTypeRepository.save(ldd);
            count++;
        }
        if(existingLivret == null) {
            accountTypeRepository.save(livret);
            count++;
        }

        int finalCount = count;

        return finalCount;
    }
}

