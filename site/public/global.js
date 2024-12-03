function validarSessao() {

    var id = sessionStorage.ID_USUARIO
    
    if (id = 1) {
        var navHome = document.getElementById("homeNav")
        navHome.innerHTML = `BobIA`

    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../index.html";

}

validarSessao()