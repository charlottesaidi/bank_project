import React, { useEffect, useState } from "react";

import axios from "axios";

// components

import { userService } from "@services/index";

// components
import CardSettings from "@components/Cards/CardSettings.js";
import CardProfile from "@components/Cards/CardProfile.js";

// layout for page
import Admin from "@layouts/Admin.js";

export default function Settings() {
  const [user, setUser] = useState(userService.user);

  useEffect(() => {
    let user = JSON.parse(localStorage.getItem("user"));
    const token = user.token;
    const bankerId = user.user.id;
    const api = `http://localhost:8080/users/${bankerId}`;
    axios
      .get(api, { headers: { Authorization: `Bearer ${token}` } })
      .then((res) => {
        // console.log(res.data);
        setUser(res.data);
      })
      .catch((err) => {
        console.log(err);
      });
  }, []);

  return (
    <>
      <div className="flex flex-wrap">
        <div className="w-full lg:w-8/12 px-4">
          <CardSettings data={user} />
        </div>
        <div className="w-full lg:w-4/12 px-4">
          <CardProfile data={user} />
        </div>
      </div>
    </>
  );
}

Settings.layout = Admin;
