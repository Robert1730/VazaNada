function validarSessao() {

    var permissao = sessionStorage.PERMISSAO
    var nome = sessionStorage.NOME_USUARIO
    var spanNivel = document.getElementById("nivelSuporte")
    var spanNome = document.getElementById("nomeSuporte")

    spanNivel.innerHTML = permissao
    spanNome.innerHTML = nome
    
    if (permissao == 'N3') {
        var divBob = document.getElementById("divBob")
        divBob.style.display = "none";

    }
}

validarSessao()