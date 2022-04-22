package com.nsf.bank.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "changing_rate_dates")
public class ChangingRateDate {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_changing_rate_date")
    private int id;

    private Date start_date;

    private Date end_date;

    public ChangingRateDate() {}

    public ChangingRateDate(int id, Date start_date, Date end_date) {
        this.id = id;
        this.start_date = start_date;
        this.end_date = end_date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getStart_date() {
        return start_date;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }
}
