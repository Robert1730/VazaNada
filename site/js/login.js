function login() {
    
    var email = document.getElementById("input_email").value
    var senha = document.getElementById("input_senha").value


    if (email == "vznd.empresa@sptech.school" ) {
            
      if(senha == "VazaNada#2024") {

        window.location.href = "../html/dashboard.html"; //redirecionamento para a tela de dash
      
      } else {
          divvalidarSenha.innerHTML = `⛔ Senha ou usuário incorreto(s)`
      }

    } else{
        divvalidarSenha.innerHTML = `⛔ Senha ou usuário incorreto(s)`
      
      }

      if(senha =='') {
        divvalidarSenha.innerHTML = `⛔ Insira algo`
      }

  }
  
  function home() {
    window.location.href = "../index.html"; //redirecionar para a home
  }