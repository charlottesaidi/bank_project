document.addEventListener("DOMContentLoaded", function(event) {
    let form = document.querySelector(".dashboard-account-form")
    if (form) {
        let account = document.querySelector(".select-account");


        // Check fields
        form.addEventListener("submit", function(e){
            e.preventDefault();
            let isValid = true;
            let valueAccount = account.value;



                let xhttp = new XMLHttpRequest();
                xhttp.open("POST", "dashboardAjaxServlet", true);
                xhttp.setRequestHeader("Content-Type", "application/json");
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        // Response
                        var response = this.responseText;
                        if (response.length != 0) {
                            let valueResponses = JSON.parse(response);
                        }
                        else {
                            window.location.href = "dashboard";
                        }
                    }
                };
                let data = {account:valueAccount};
                xhttp.send(JSON.stringify(data));
        });
    }
});