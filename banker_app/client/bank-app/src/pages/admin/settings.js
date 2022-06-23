import React, { useEffect, useState } from "react";

import axios from "axios";

// services

import { userService } from "@services/index";

// components
import CardSettings from "@components/Cards/CardSettings.js";
import CardProfile from "@components/Cards/CardProfile.js";

// layout for page
import Admin from "@layouts/Admin.js";

export default function Settings() {
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

  return (
    <>
      <div className="flex flex-wrap">
        <div className="w-full lg:w-8/12 px-4">
          <CardSettings data={user} />
        </div>
        <div className="w-full lg:w-4/12 px-4">
          <CardProfile clients={customer} data={user} />
        </div>
      </div>
    </>
  );
}

Settings.layout = Admin;
