function mudarSenha() {

    var inputSenha = document.getElementById("input_senha")
    var buttonSenha = document.getElementById("olhoSenha")

    if(inputSenha.type == "password") {
      inputSenha.type = "text"
      buttonSenha.src = "../assets/img/vendoSenha.png"

    } else {
      inputSenha.type = "password"
      buttonSenha.src = "../assets/img/naoVendoSenha.png"
    }

  }