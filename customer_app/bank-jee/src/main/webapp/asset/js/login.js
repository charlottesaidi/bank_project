document.addEventListener("DOMContentLoaded", function(event) {
    let form = document.querySelector(".customer-login-form")
    if (form) {
        let identifiant = document.querySelector(".customer-login-identifiant");
        let password = document.querySelector(".customer-login-password");
        let errorIdentifiant = document.querySelector(".customer-login-identifiant-error");
        let errorPassword = document.querySelector(".customer-login-password-error");

        // Check fields
        form.addEventListener("submit", function(e){
            e.preventDefault();
            let isValid = true;
            let valueIdentifiant = identifiant.value;
            let valuePassword = password.value;

            if (valueIdentifiant.length == 0) {
                let valueErrorIdentifiant = 'Veuillez renseigner un identifiant';
                errorIdentifiant.innerHTML = valueErrorIdentifiant;
                isValid = false;
            }
            if (valuePassword.length == 0) {
                let valueErrorPassword = 'Veuillez renseigner un mot de passe';
                errorPassword.innerHTML = valueErrorPassword;
                isValid = false;
            }
            if (isValid) {
                let xhttp = new XMLHttpRequest();
                xhttp.open("POST", "loginAjaxServlet", true);
                xhttp.setRequestHeader("Content-Type", "application/json");
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        // Response
                        var response = this.responseText;
                        if (response.length != 0) {
                            let valueErrorIdentifiant = response;
                            let valueErrorPassword = response;
                            errorIdentifiant.innerHTML = valueErrorIdentifiant;
                            errorPassword.innerHTML = valueErrorPassword;
                        }
                        else {
                            window.location.href = "dashboard";
                        }
                    }
                };
                let data = {identifiant:valueIdentifiant,password:valuePassword};
                xhttp.send(JSON.stringify(data));
            }
        });
    }
});