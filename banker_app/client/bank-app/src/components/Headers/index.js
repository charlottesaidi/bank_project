import React from "react";
import styled from '@emotion/styled';
import Link from 'next/link';

const Container = styled.header`
  width: 100%;
  display: flex;
  align-items: center;
  padding: 10px 80px;
  position: fixed;
  z-index: 100;
  top: 0;
  left: 0;

  .logo {
    width: 150px;
    height: 50px;
    background: center / contain no-repeat url("/img/logo.svg");
    margin-right: 50px;
  }
`;

const Ul = styled.ul`
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  height: 100%;

  li {
    margin: 0 10px;

    a {
      color: var(--white);
      text-transform: uppercase;
      font-size: 0.9rem;
      letter-spacing: 1.5px;
    }
  }
`;


export default function Header() {

    return (
        <>
            <Container>
                <Link href="/" passHref>
                    <a className={"logo"}/>
                </Link>
                <nav>
                    <Ul>
                        <li>
                            <Link href="/">
                                <a>Accueil</a>
                            </Link>
                        </li>
                        <li>
                            <Link href="#">
                                <a>Connexion</a>
                            </Link>
                        </li>
                    </Ul>
                </nav>
            </Container>
        </>
    );
}
