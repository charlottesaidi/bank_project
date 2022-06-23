import React, { useEffect, useState } from "react";

import axios from "axios";

// services

import { userService } from "@services/index";

// components

import CardStats from "@components/Cards/CardStats.js";

export default function HeaderStats() {
  const [user, setUser] = useState(userService.user);
  const [customer, setCustomer] = useState(userService.user);
  // const [account, setAccount] = useState(userService.user);

  useEffect(() => {
    let user = JSON.parse(localStorage.getItem("user"));
    const token = user.token;
    const bankerId = user.user.id;
    const bankerUsername = user.user.username;
    const api = `http://localhost:8080/`;
    axios
      .get(api + `users/${bankerId}`, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((res) => {
        setUser(res.data);
      })
      .catch((err) => {
        console.error(err);
      });

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

  }, []);
// console.log(customer); 
return (
    <>
      {/* Header */}
      <div className="relative bg-blueGray-800 md:pt-32 pb-32 pt-12">
        <div className="px-4 md:px-10 mx-auto w-full">
          <div>
            {/* Card stats */}
            <div className="flex flex-wrap">
              <div className="w-full lg:w-6/12 xl:w-3/12 px-4">
                <CardStats 
                  statSubtitle="Total € client"
                  statTitle= ""
                  statArrow="up"
                  statPercent="3.48"
                  statPercentColor="text-emerald-500"
                  statDescripiron="Depuis le mois dernier"
                  statIconName="far fa-chart-bar"
                  statIconColor="bg-red-500"
                />
              </div>
              <div className="w-full lg:w-6/12 xl:w-3/12 px-4">
                <CardStats 
                  statSubtitle="Nombre client"
                  statTitle={ customer.length }
                  statArrow="down"
                  statPercent="3.48"
                  statPercentColor="text-red-500"
                  statDescripiron="depuis le mois dernier"
                  statIconName="fas fa-chart-pie"
                  statIconColor="bg-orange-500"
                />
              </div>
              <div className="w-full lg:w-6/12 xl:w-3/12 px-4">
                <CardStats 
                  statSubtitle="Livret A"
                  statTitle="924"
                  statArrow="down"
                  statPercent="1.10"
                  statPercentColor="text-orange-500"
                  statDescripiron="Depuis le mois dernier"
                  statIconName="fas fa-users"
                  statIconColor="bg-pink-500"
                />
              </div>
              <div className="w-full lg:w-6/12 xl:w-3/12 px-4">
                <CardStats 
                  statSubtitle="Compte courant"
                  statTitle="49,65%"
                  statArrow="up"
                  statPercent="12"
                  statPercentColor="text-emerald-500"
                  statDescripiron="Depuis le mois dernier"
                  statIconName="fas fa-percent"
                  statIconColor="bg-lightBlue-500"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
