import React, { useEffect, useState } from "react";
import { BehaviorSubject } from "rxjs";
import getConfig from "next/config";

import axios from "axios";

// components

import { userService } from "@services/index";

import CardSettings from "@components/Cards/CardSettings.js";
import CardProfile from "@components/Cards/CardProfile.js";

// layout for page

import Admin from "@layouts/Admin.js";

export default function Settings() {
  // useEffect(() => {
  //   let user = JSON.parse(localStorage.getItem("user"));
  //   const token = user.token;
  //   const bankerId = user.user.id;
  //   // const [user, setUser] = useState(userService.user);
  //   // console.log(bankerId);
  //   const api = `http://localhost:8080/users/${bankerId}`;
  //   axios
  //     .get(api, { headers: { Authorization: `Bearer ${token}` } })
  //     .then((res) => {
  //       console.log(res.data);
  //     })
  //     .catch((err) => {
  //       console.log(err);
  //     });
  // }, []);

  return (
    <>
      <div className="flex flex-wrap">
        <div className="w-full lg:w-8/12 px-4">
          <CardSettings />
        </div>
        <div className="w-full lg:w-4/12 px-4">
          <CardProfile />
        </div>
      </div>
    </>
  );
}

Settings.layout = Admin;

// export async function getStaticProps() {
//   const res = await fetch(
//     `http://localhost:8080/users/1`
//   );
//   const data = await res.json();

//   return {
//     props: {
//       data,
//     },
//     revalidate: 60,
//   };
// }
