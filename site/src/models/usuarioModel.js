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
    console.log('estou função criticoKPI')
    var instrucaoSql = `
        SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
        JOIN sensor sn ON s.idSetor = sn.fkSetor
        JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.qtdGasVazado >= 60.0;
    `;
    return database.executar(instrucaoSql);
}

function seguroKPI() {
    console.log('estou função seguroKPI ')
    var instrucaoSql = `
        SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
		left JOIN sensor sn ON s.idSetor = sn.fkSetor
		left JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.idMedicao IS NULL ;
    `;
    return database.executar(instrucaoSql);
}

function alertaKPI() {
    console.log('estou função alertaKPI')
    var instrucaoSql = `
        SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
        JOIN sensor sn ON s.idSetor = sn.fkSetor
        JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.qtdGasVazado > 0.0 AND m.qtdGasVazado < 60.0;
    `;
    return database.executar(instrucaoSql);
}

function dashDATA() {
    console.log('estou função dashDATA')
    var instrucaoSql = `
     SELECT 
        CASE 
            WHEN MONTH(dtComecoVazamento) = 1 THEN 'Janeiro'
            WHEN MONTH(dtComecoVazamento) = 2 THEN 'Fevereiro'
            WHEN MONTH(dtComecoVazamento) = 3 THEN 'Março'
            WHEN MONTH(dtComecoVazamento) = 4 THEN 'Abril'
            WHEN MONTH(dtComecoVazamento) = 5 THEN 'Maio'
            WHEN MONTH(dtComecoVazamento) = 6 THEN 'Junho'
            WHEN MONTH(dtComecoVazamento) = 7 THEN 'Julho'
            WHEN MONTH(dtComecoVazamento) = 8 THEN 'Agosto'
            WHEN MONTH(dtComecoVazamento) = 9 THEN 'Setembro'
            WHEN MONTH(dtComecoVazamento) = 10 THEN 'Outubro'
            WHEN MONTH(dtComecoVazamento) = 11 THEN 'Novembro'
            WHEN MONTH(dtComecoVazamento) = 12 THEN 'Dezembro'
        END AS nome_mes,                                        -- Nome do mês em português
        YEAR(dtComecoVazamento) AS ano,                         -- Ano da medição
        COUNT(*) AS quantidade_vazamentos                       -- Contagem de vazamentos por mês
    FROM 
        medicao
    GROUP BY 
        ano, nome_mes
    ORDER BY 
    ano, FIELD(nome_mes, 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');


    `;
    return database.executar(instrucaoSql);
} 

function dashLINHA() {
    console.log('estou função alertaKPI')
    var instrucaoSql = `
        
    SELECT DATE_FORMAT(dtComecoVazamento, '%H:%i') AS horario, qtdGasVazado
    FROM medicao ORDER BY dtComecoVazamento;
    `;
    return database.executar(instrucaoSql);
}

function buscarDadosPizza(mes) {
    console.log("MES AQUI", mes)
    var instrucaoSql = `
    SELECT COUNT(dtcomecoVazamento) AS 'Quantidade', setor.nome AS 'Setor' FROM medicao JOIN sensor ON fkSensor = idSensor JOIN setor ON fkSetor = idSetor WHERE dtComecoVazamento like '_____${mes}%' GROUP BY setor.nome;
    `;
    
    console.log('Estou na função grafico de pizza')
    console.log("Executando a instrução SQL: \n" + instrucaoSql);

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
    seguroKPI,
    alertaKPI,
    dashDATA,
    dashLINHA,
    buscarDadosPizza,
    cadastrar
};