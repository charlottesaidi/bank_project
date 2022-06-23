import React, { useEffect, useState } from "react";
import dynamic from 'next/dynamic';

import axios from "axios";

// services

import { userService } from "@services/index";

// components

import CardLineChart from "@components/Cards/CardLineChart.js";
// import CardBarChart from "@components/Cards/CardBarChart.js";
import CardPageVisits from "@components/Cards/CardPageVisits.js";
import CardSocialTraffic from "@components/Cards/CardSocialTraffic.js";

const CardBarChart = dynamic(() => import('@components/Cards/CardBarChart.js'), {
  ssr: false,
})

// layout for page

import Admin from "@layouts/Admin.js";

export default function Dashboard() {
  const [customer, setCustomer] = useState(userService.user);
  const [accounts, setAccount] = useState(userService.user);

  // console.log(customer);
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

  // calcul nombre de comptes crées (par type et par année)
  let current_year_ccp = [];
  let last_year_ccp = [];
  let current_year_la = [];
  let last_year_la = [];
  let current_year_ldd = [];
  let last_year_ldd = [];

  accounts.forEach((el) => {
    // ! au refresh on me dit que el.account_type est undefined !
    if(el.account_type?.name == "CPT_COURANT") {
      if(new Date(el.created_at).getFullYear() == new Date().getFullYear()) {
        current_year_ccp.push(el) 
      }
      if(new Date(el.created_at).getFullYear() == new Date().getFullYear() - 1) {
        last_year_ccp.push(el)
      }
    }
    if(el.account_type?.name == "LIVRET_A") {
      if(new Date(el.created_at).getFullYear() == new Date().getFullYear()) {
        current_year_la.push(el) 
      }
      if(new Date(el.created_at).getFullYear() == new Date().getFullYear() - 1) {
        last_year_la.push(el)
      }
    }
    if(el.account_type?.name == "LIVRET_DEVELOPPEMENT_DURABLE") {
      if(new Date(el.created_at).getFullYear() == new Date().getFullYear()) {
        current_year_ldd.push(el) 
      }
      if(new Date(el.created_at).getFullYear() == new Date().getFullYear() - 1) {
        last_year_ldd.push(el)
      }
    }
  })

  let current_year = [current_year_ccp.length, current_year_la.length, current_year_ldd.length];
  let last_year = [last_year_ccp.length, last_year_la.length, last_year_ldd.length]

  return (
    <>
      <div className="flex flex-wrap">
        <div className="w-full xl:w-8/12 mb-12 xl:mb-0 px-4">
          <CardLineChart />
        </div>
        <div className="w-full xl:w-4/12 px-4">
          <CardBarChart current_year={current_year} last_year={last_year}/>
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
