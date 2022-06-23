import React, { useEffect, useState } from "react";

import axios from "axios";

// services

import { userService } from "@services/index";

// components
import CardTable from "@components/Cards/CardTable.js";

// layout for page
import Admin from "@layouts/Admin.js";

export default function Tables() {
  const [customer, setCustomer] = useState(userService.user);
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

  }, []);
  return (
    <>
      <div className="flex flex-wrap mt-4">
        <div className="w-full mb-12 px-4">
          <CardTable props={customer} />
        </div>
      </div>
    </>
  );
}

Tables.layout = Admin;
