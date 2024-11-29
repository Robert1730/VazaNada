var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT idUsuario, nome, email, fkUnidade as UnidadeID FROM usuario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function verificarEmail() {
    console.log('estou função verificarEmail')
    var instrucaoSql = `
        SELECT email FROM usuario;
    `;
  
    return database.executar(instrucaoSql);
  }

  function criticoKPI() {
    console.log('estou função kpi1')
    var instrucaoSql = `
        SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
        JOIN sensor sn ON s.idSetor = sn.fkSetor
        JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.qtdGasVazado <= 4.0;
    `;
    return database.executar(instrucaoSql);
  }



// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, email, senha, fkUnidade) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha, fkUnidade);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO usuario (nome, email, senha, fkUnidade) VALUES ('${nome}', '${email}', '${senha}','${fkUnidade}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    verificarEmail,
    criticoKPI,
    cadastrar
};