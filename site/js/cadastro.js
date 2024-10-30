    // Váriaveis para validação

    var nomeValidado = false
    var emailValidado = false
    var cnpjValidado = false
    var senhaValidado = false
    var confirmacaoValidado = false
    var razaoValidado = false

  function cadastrar(){

  //variaveis para as inputs

    var nome = document.getElementById("input_nome").value
    var email = document.getElementById("input_email").value
    var cnpj = document.getElementById("input_cnpj").value
    var senha = document.getElementById("input_senha").value
    var confirmacao = document.getElementById("input_confirmacao_senha").value
    var razao = document.getElementById("input_razao").value

   // Validações para redirecionar
  
    if(nomeValidado == false || emailValidado == false || cnpjValidado == false || senhaValidado == false || confirmacaoValidado == false || razaoValidado == false){


  //validar nome

    if(nome.length > 0){
        divvalidarNome.innerHTML = `✅`;
        nomeValidado = true

    } else {
        divvalidarNome.innerHTML = `⛔ Insira um nome válido `;
        nomeValidado = false
    }


    //validação do email

    if (email.includes("@")) {
        divvalidarEmail.innerHTML = `✅`
        emailValidado = true

    } else {
        divvalidarEmail.innerHTML = `⛔ Insira um email válido `
        emailValidado = false
    }
    
    
//validação do cnpj

    if(cnpj.length == 18){
        divvalidarCNPJ.innerHTML = `✅`
        cnpjValidado = true

    }  else {
       divvalidarCNPJ.innerHTML = `⛔ Insira um CNPJ válido <br>
       Exemplo:"00.000.000/0000-00"`
       cnpjValidado = false
    }

    if(senha.includes(" ")){
      divvalidarSenha.innerHTML = `Espaços não são permitidos` 
    }


    // validação razão 

    if(razao.length > 0){

      divvalidarRazao.innerHTML = `✅`
      razaoValidado = true

    } else {
      divvalidarRazao.innerHTML = `⛔ Insira uma razão social válida`
      razaoValidado = false

    }


//variaveis pro if e for da senha

  var temNumero = false;
  var temNumeroCorreto = `⛔`
  var temLetram = false;
  var temLetramCorreto= `⛔`;
  var temLetraM = false;
  var temLetraMCorreto= `⛔`;

if (senha.length >= 8){
    
    for (var atual = 0; atual < senha.length; atual++) {
       
        var atual2 = senha[atual];
        
        if(atual2 >= 'A' && atual2 <= 'Z') {
            temLetraM = true;
            temLetraMCorreto = `✅`

        } else if (atual2 >= 'a' && atual2 <= 'z') {
            temLetram = true;
            temLetramCorreto = `✅`

        } else if (atual2 >= '0' && atual2 <= '9') { 
            temNumero = true;
            temNumeroCorreto = `✅`

        }
    }

    if (temLetraM && temLetram && temNumero) {
        divvalidarSenha.innerHTML = `✅`;
        senhaValidado = true

    } else {
        divvalidarSenha.innerHTML = `
          ⛔ Senha deve conter ao menos 8 caracteres válidos:<br>
          ${temLetraMCorreto} Letra(s) Maiúscula(s), ${temLetramCorreto} minúsculas(s), ${temNumeroCorreto}número(s)`;
          senhaValidado = false
    }
} else {
  divvalidarSenha.innerHTML = `⛔ Senha deve ter pelo menos 8 caracteres.`;
}


//confirmação da senha

if(confirmacao.length >= 8) {
    if(confirmacao == senha) {
    
        divvalidarSenha2.innerHTML = `✅`;
        confirmacaoValidado = true

    } else {
    
        divvalidarSenha2.innerHTML = ` ⛔ Senhas diferentes`; 
        confirmacaoValidado = false
    }
} else {
    
    divvalidarSenha2.innerHTML = `⛔ Insira algo válido`;
    confirmacaoValidado = false
    } 

    if(nomeValidado && emailValidado && cnpjValidado && senhaValidado && confirmacaoValidado && razaoValidado){
        botao.innerHTML = `Logar`

        input_nome.readOnly = true
        input_email.readOnly = true
        input_cnpj.readOnly = true
        input_confirmacao_senha.readOnly = true
        input_razao.readOnly = true
        input_senha.readOnly = true
    }

  } else {
    window.location.href = "./login.html"
  }

}

  function home() {
    window.location.href = "../index.html";
  }
