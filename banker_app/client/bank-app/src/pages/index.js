import React from "react";
import Layout from "@components/Layout";

Home.title = "BankMe | Home";

export default function Home() {
  return <></>;
}

Home.getLayout = function getLayout(page) {
  return <Layout>{page}</Layout>;
};
