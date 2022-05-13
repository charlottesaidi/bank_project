import { Html, Head, Main, NextScript } from "next/document";

export default function Document() {
  return (
    <Html>
      <Head>
          <meta charSet="utf-8" />
          <meta name="theme-color" content="#000000" />
          {/* <link rel="shortcut icon" href="/img/brand/favicon.ico" /> */}
          {/* <link
            rel="apple-touch-icon"
            sizes="76x76"
            href="/img/brand/apple-icon.png"
          /> */}
          <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
          integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
          crossorigin="anonymous"
          referrerpolicy="no-referrer"
        />
        </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
