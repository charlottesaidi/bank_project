<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 22/04/2022
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="inc/header.jsp" %>

<section id="transfer">
    <div class="wrap">
        <div class="transfer-container">
            <form method="post" action="">
                <div class="transfer-container__from">
                    <label for="account-from-select" class="transfer-container-title">Depuis quel compte ?</label>
                    <select name="account-from" id="account-from-select">
                        <option value="">Sélectionner un compte</option>
                        <option value="compte-courant">Compte Courant</option>
                        <option value="pel">PEL</option>
                        <option value="livret-a">Livret A</option>
                    </select>
                </div>
                <div class="transfer-container__to">
                    <div class="transfer-container__split-first">
                        <label for="account-to-select" class="transfer-container-title">Vers quel bénéficiaire ?</label>
                        <div class="add__accounts">ajouter un bénéficiaire</div>
                    </div>
                    <select name="account-to" id="account-to-select">
                        <option value="">Sélectionner un bénéficiaire</option>
                        <option value="compte-courant">Compte Courant</option>
                        <option value="pel">PEL</option>
                        <option value="livret-a">Livret A</option>
                    </select>
                </div>
                <div class="transfer-container__info">
                    <div class="transfer-container__split-second">
                        <p class="transfer-container-title">Informations du virement</p>
                        <p class="transfer-container-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
                            do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna id volutpat lacus
                            laoreet.</p>
                    </div>
                    <div class="transfer-container__form">
                        <input type="text" id="money" name="money" class="money" placeholder="Saisir le montant">
                        <input type="text" id="choice" name="choice" class="choice" placeholder="Saisir le motif">
                        <input type="submit" value="envoyer" class="send button__gray submit-form">
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>


<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js" defer></script>
<script src="asset/js/dashboard.js" type="text/javascript" defer></script>
<%@ include file="inc/footer.jsp" %>