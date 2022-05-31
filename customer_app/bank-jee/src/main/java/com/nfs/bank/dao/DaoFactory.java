package com.nfs.bank.dao;

public class DaoFactory {

    private static CustomerDao customerDao;

    private DaoFactory(){}

    public static CustomerDao getCustomerDao(){
        if(customerDao == null){
            customerDao = new CustomerDao();
        }
        return customerDao;
    }
}
