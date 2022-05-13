package com.nfs.bank.dao;

public class DaoFactory {

    private static CustomerDao customerDao;
    private static UserDao userDao;

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
}
