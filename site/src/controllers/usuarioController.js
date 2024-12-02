var usuarioModel = require("../models/usuarioModel");
// var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                                    res.json({
                                        id: resultadoAutenticar[0].id,
                                        email: resultadoAutenticar[0].email,
                                        nome: resultadoAutenticar[0].nome,
                                        senha: resultadoAutenticar[0].senha,
                                        bairro: resultadoAutenticar[0].bairro,
                                        estado: resultadoAutenticar[0].estado,
                                        cep: resultadoAutenticar[0].cep
                                       
                                    });
                               
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function verificarEmail(req, res) {
    usuarioModel.verificarEmail().then((resultado) => {
      res.status(200).json(resultado);
    });
  }
  
  function criticoKPI (req, res) {
    usuarioModel.criticoKPI().then((resultado) => {
      res.status(200).json(resultado);
    });
  }

  function seguroKPI (req, res) {
    usuarioModel.seguroKPI().then((resultado) => {
      res.status(200).json(resultado);
    });
  }

  function alertaKPI (req, res) {
    usuarioModel.alertaKPI().then((resultado) => {
      res.status(200).json(resultado);
    });
  }

  function dashDATA(req, res) {
    usuarioModel.dashDATA().then((resultado) => {
      res.status(200).json(resultado);
    });
  }

  function dashLINHA(req, res) {
    usuarioModel.dashLINHA().then((resultado) => {
      res.status(200).json(resultado);
    });
  }

function cadastrar(req, res) {
    console.log('Entrando na função cadastrar no controller');
    console.log('Dados recebidos:', req.body); 
    console.log(req.body.idEmpresaVincularServer);
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    // var bairro = req.body.bairroServer;
    // var estado = req.body.estadoServer;
    // var cep = req.body.cepServer;
    var fkUnidade = req.body.idEmpresaVincularServer;
    
    

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
        console.log('Seu nome está undefined!')
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
        console.log('Seu email está undefined!')
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
        console.log('Seu senha está undefined!')
    }  else if (fkUnidade == undefined) {
        res.status(400).send("Sua unidade a vincular está undefined!");
        console.log('Sua unidade a vincular está undefined!')
    } else {


      

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, senha, fkUnidade)
            .then(
                function (resultado) {
                    res.json(resultado);
                    console.log('estou no controller de cadastro')
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    autenticar,
    verificarEmail,
    criticoKPI,
    seguroKPI,
    alertaKPI,
    dashDATA,
    dashLINHA,
    cadastrar
}