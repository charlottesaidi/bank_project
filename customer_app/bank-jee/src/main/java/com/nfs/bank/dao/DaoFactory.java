package com.nfs.bank.dao;

public class DaoFactory {

    private static CustomerDao customerDao;
    private static UserDao userDao;
    private static AccountDao accountDao;
    private static TransactionDao transactionDao;

    private DaoFactory(){}

    public static CustomerDao getCustomerDao(){
        if(customerDao == null){
            customerDao = new CustomerDao();
        }
        return customerDao;
    }
    public static UserDao getUserDao(){
        if(userDao == null){
            userDao = new UserDao();
        }
        return userDao;
    }
    public static AccountDao getAccountDao(){
        if(accountDao == null){
            accountDao = new AccountDao();
        }
        return accountDao;
    }
    public static TransactionDao getTransactionDao(){
        if(transactionDao == null){
            transactionDao = new TransactionDao();
        }
        return transactionDao;
    }
}
