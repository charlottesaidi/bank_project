import React from "react";
import "@styles/reset.css";
import "@styles/globals.css";
import "@styles/general.css";
import Layout from "@components/Layout";
import Head from "next/head";

export default function MyApp({ Component, pageProps }) {
  // useEffect(() => {
  //   import("flowbite").then((mod) => {
  //     // my-module is ready
  //     console.log(mod);
  //   });
  // }, []);
  return (
    <>
      <Head>
        <meta charset="UTF-8" />
        <meta name="author" content="Bank Me" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>{Component.title}</title>
        <link rel="icon" href="" />
      </Head>
      <Layout>
        <Component {...pageProps} />
      </Layout>
    </>
  );
}
