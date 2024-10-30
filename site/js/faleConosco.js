
var novaMensagem = false

function enviar() {

        // Variaveis com os valores

        var nome = document.getElementById("ipt_nome").value;
        var empresa = document.getElementById("ipt_empresa").value;
        var email = document.getElementById("ipt_email").value;
        var telefone = document.getElementById("ipt_contato").value;
        var mensagemCliente = document.getElementById("textArea_mensagem").value;
        var emailCheck = document.getElementById("chkipt_email").checked;
        var telefoneCheck = document.getElementById("chkipt_telefone").checked;

        // Variaveis das validações

        var nomeValidado = false
        var empresaValidada = false
        var emailValidado = false
        var telefoneValidado = false
        var mensagemClienteValidado = false
        var telefoneEmailValidado = true

        div_validarNome.innerHTML = ``
        div_validarEmpresa.innerHTML = ``
        div_validarEmail.innerHTML = ``
        div_validarContato.innerHTML = ``
        div_validarMensagem.innerHTML = ``

        if(novaMensagem == true) {
            location.reload();
        }

        if(nome == '' || nome == " ") {
            div_validarNome.innerHTML = `⛔ Insira um nome válido `;
 
        } else {
            nomeValidado = true
        }

        if(empresa == '' || empresa == " ") {    
            div_validarEmpresa.innerHTML = `⛔ Insira uma empresa válida`;
        
        } else {
            empresaValidada = true
        
        }

        if(emailCheck || telefoneCheck) {
            div_validarEscolha.innerHTML = ``
           
            if(emailCheck && telefoneCheck) {
                telefoneEmailValidado = false
            }

            if(emailCheck && (email == '' || email == " " || !email.includes("@"))) {
                div_validarEmail.innerHTML = `⛔ Insira um email válido `;
            
            } else {
                emailValidado = true
            }

            if(telefoneCheck && (telefone <=0 || telefone.length < 13)) {
                div_validarContato.innerHTML = `⛔ Insira um contato válido, EX: +55 11 9 9999 9999`;
            
            } else {
                telefoneValidado = true
            } 

            if(telefoneEmailValidado == false && emailValidado && telefoneValidado) {
                telefoneEmailValidado = true
            }

        } else {
            div_validarEscolha.innerHTML = `⛔ Escolha uma forma de contato`;
        
        }

        if(mensagemCliente == '' || mensagemCliente == " ") {    
            div_validarMensagem.innerHTML = `⛔ Insira uma mensagem válida`;
        
        } else {
            mensagemClienteValidado = true
    
        }

        if(nomeValidado && empresaValidada && (telefoneValidado || emailValidado) && mensagemClienteValidado && telefoneEmailValidado){
            div_validarMensagem.innerHTML = `✅ Mensagem enviada com sucesso, entraremos em contato em breve`
            div_validarMensagem.style.color = 'white';
            buttonEnviar.innerHTML = `Enviar uma nova mensagem?`
            buttonEnviar.style.width = `15vw`
            novaMensagem = true

            // Setando as inputs como apenas leitura
            
            ipt_nome.readOnly = true
            ipt_contato.readOnly = true
            ipt_email.readOnly = true
            ipt_empresa.readOnly = true
            textArea_mensagem.readOnly = true
            chkipt_email.readOnly = true
            chkipt_telefone.readOnly = true

        }

    }
