import React, { useEffect, useState } from "react";

import axios from "axios";

// services

import { userService } from "@services/index";

// components

import CardLineChart from "@components/Cards/CardLineChart.js";
import CardBarChart from "@components/Cards/CardBarChart.js";
import CardPageVisits from "@components/Cards/CardPageVisits.js";
import CardSocialTraffic from "@components/Cards/CardSocialTraffic.js";

// layout for page

import Admin from "@layouts/Admin.js";

export default function Dashboard() {
  const [customer, setCustomer] = useState(userService.user);
  const [accounts, setAccount] = useState(userService.user);
  let negative_accounts = [];
  console.log(accounts);
  useEffect(() => {
    let user = JSON.parse(localStorage.getItem("user"));
    const token = user.token;
    const bankerUsername = user.user.username;
    const api = `http://localhost:8080/`;

    axios
      .get(api + `api/bankers/${bankerUsername}/customers`, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((res) => {
        setCustomer(res.data);
      })
      .catch((err) => {
        console.error(err);
      });

      axios
      .get(api + `api/bankers/${bankerUsername}/customers/accounts`, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((res) => {
        setAccount(res.data);
      })
      .catch((err) => {
        console.error(err);
      });      
  }, []);
  // const subTotal = customer.reduce((acc, product) => {
  //   return acc + product.price * product.quantity;
  // }, 0);

  // console.log(subTotal);
  return (
    <>
      <div className="flex flex-wrap">
        <div className="w-full xl:w-8/12 mb-12 xl:mb-0 px-4">
          <CardLineChart />
        </div>
        <div className="w-full xl:w-4/12 px-4">
          <CardBarChart props={accounts}/>
        </div>
      </div>
      <div className="flex flex-wrap mt-4">
        <div className="w-full xl:w-8/12 mb-12 xl:mb-0 px-4">
          <CardPageVisits props={customer} />
        </div>
        <div className="w-full xl:w-4/12 px-4">
          <CardSocialTraffic props={customer}/>
        </div>
      </div>
    </>
  );
}

Dashboard.layout = Admin;
