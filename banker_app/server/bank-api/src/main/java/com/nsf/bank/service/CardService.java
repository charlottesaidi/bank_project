package com.nsf.bank.service;

import com.nsf.bank.entity.Account;
import com.nsf.bank.entity.Card;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;

@Service
public class CardService {
    public Card createAccountCard(Account account) {
        Card card = new Card();
        card.setNumber(RandomStringUtils.random(16, false, true));
        card.setCvc(RandomStringUtils.random(3, false, true));
        card.setValidity_date(generateValidityDate());
        card.setAccount(account);

        return card;
    }

    public Card updateAccountCardDetails(Account account) {
        Card card = account.getCard();
        card.setNumber(RandomStringUtils.random(16, false, true));
        card.setCvc(RandomStringUtils.random(3, false, true));
        card.setValidity_date(generateValidityDate());

        return card;
    }

    public Date generateValidityDate() {
        Date randomDate = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(randomDate);
        c.add(Calendar.YEAR, 2);
        Date newDate = c.getTime();

        return newDate;
    }
}
