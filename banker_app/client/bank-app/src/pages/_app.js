import React from "react";
import "@styles/reset.css";
import "@styles/globals.css";
import "@styles/tailwind.css";
import "@styles/general.css";
import Head from "next/head";

export default function MyApp({ Component, pageProps }) {
  const Layout = Component.layout || (({ children }) => <>{children}</>);
  return (
    <>
      <Head>
        <meta charset="UTF-8" />
        <meta name="author" content="Bank Me" />
        <meta
          name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no"
        />
        <title>{Component.title}</title>
        <link rel="icon" href="" />
      </Head>
        <Layout>
          <Component {...pageProps} />
        </Layout>
    </>
  );
}
