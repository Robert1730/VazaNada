CREATE DATABASE vazaNada;
USE vazaNada;
DROP DATABASE vazaNada;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(255),
nome VARCHAR(255),
responsavel VARCHAR(80),
telefone VARCHAR(11)
)AUTO_INCREMENT 1000;

CREATE TABLE unidade (
idUnidade INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255),
logradouro VARCHAR(100),
numero VARCHAR(10),
bairro VARCHAR(100),
cidade VARCHAR(45),
estado CHAR(2),
cep CHAR(9),
codigo_ativacao VARCHAR(45),
fkEmpresa INT,
CONSTRAINT fkEmpresaUnidade 
    FOREIGN KEY (fkEmpresa) 
        REFERENCES empresa(idEmpresa)
) AUTO_INCREMENT 1000;

CREATE TABLE setor (
idSetor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60),
descricao VARCHAR(100),
fkUnidade INT,
CONSTRAINT fkSetorUnidade 
    FOREIGN KEY (fkUnidade)
        REFERENCES unidade(idUnidade)
);

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
dtInstalacao DATETIME,
dtUltimaManutencao DATETIME,
fkSetor INT,
CONSTRAINT fkSensorSetor 
    FOREIGN KEY (fkSetor)
        REFERENCES setor(idSetor)
);

CREATE TABLE medicao (
idMedicao INT PRIMARY KEY AUTO_INCREMENT,
qtdGasVazado FLOAT,
dtComecoVazamento DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
CONSTRAINT fkMedicaoSensor 
    FOREIGN KEY (fkSensor)
        REFERENCES sensor(idSensor)
);

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
email VARCHAR(255),
senha VARCHAR(255), 
permissao CHAR (2),
CONSTRAINT chkPermissao
    CHECK (permissao IN( 'N0', 'N1', 'N2', 'N3')),
fkUnidade INT,
CONSTRAINT fkUnidadeUsuario 
    FOREIGN KEY (fkUnidade)
        REFERENCES unidade(idUnidade)
)AUTO_INCREMENT 1000;


SHOW TABLES;

-- Descrição das tabelas:
DESC empresa;
DESC unidade;
DESC setor;
DESC sensor;
DESC medicao;
DESC usuario;
-- DESC login;

-- Inserção da empresa administradora
INSERT INTO empresa (idEmpresa, razao_social, nome, responsavel, telefone) VALUES 
(1, 'VazaNada', 'VazaNada', 'Robert Ferreira de Souza', '1194456789');

-- Inserção da empresa exemplo
INSERT INTO empresa (razao_social, nome, responsavel, telefone) VALUES 
('Petrobras S.A.', 'Petrobras', 'Roberto da Silva', '2134456789');

INSERT INTO unidade (idUnidade, nome, logradouro, numero, bairro, cidade, estado, cep, fkEmpresa) VALUES 
(1,'Matrix', 'Rua Augusta', '1730', 'Jardins', 'São Paulo', 'SP', '20031-080', 1),
(DEFAULT, 'Unidade Rio de Janeiro', 'Avenida República do Chile', '65', 'Centro', 'Rio de Janeiro', 'RJ', '20031-912', 1000);

-- Inserção do usuário administrador
INSERT INTO usuario (idUsuario, nome, email, senha, permissao, fkUnidade) VALUES 
(1, 'Marcelo Gonçalves', 'marcelo.gonçalves@vazanada.com', 'Vznd@2024', 'N1', 1),
(2, 'Kaio Cassiano', 'kaio.cassiano@vazanada.com', 'Vznd@2024', 'N2', 1),
(3, 'Robert Ferreira de Souza', 'robert.souza@vazanada.com', 'Vznd@2024', 'N3', 1);

-- Inserção dos outros usuários
INSERT INTO usuario (nome, email, senha, permissao, fkUnidade) VALUES 
('Juliana Ribeiro', 'juliana.ribeiro@petrobras.com', 'senhaPetro@456', 'N0', 1000);

INSERT INTO setor (nome, descricao, fkUnidade) VALUES 
('Setor de Medição RJ', 'Medição de gasodutos na unidade RJ', 1000),
('Setor de Regulagem RJ', 'Regulagem dos gasosdutos na unidade RJ', 1000),
('Setor de Tratamento RJ', 'Tratamento dos gasosdutos na unidade RJ', 1000);

INSERT INTO sensor (nome, dtInstalacao, dtUltimaManutencao, fkSetor) VALUES 
('Sensor Átila', '2023-02-10 10:00:00', '2024-03-14 10:00:00', 1),
('Sensor Átila', '2023-02-10 10:00:00', '2024-03-14 10:00:00', 2),
('Sensor Átila', '2023-03-14 10:00:00', NULL, 3);

INSERT INTO medicao (qtdGasVazado, dtComecoVazamento, fkSensor) VALUES 
(4.1, '2024-11-25 09:45:00', 1),
(56, '2024-11-25 09:45:00', 2),
(75, '2024-11-26 14:20:00', 3);	

SELECT * FROM empresa;
SELECT * FROM unidade;
SELECT * FROM setor;
SELECT * FROM sensor;
SELECT * FROM medicao;
SELECT * FROM usuario;

-- Selects iniciais:

-- Logar usuario e pegar a permissao dele
SELECT idUsuario, nome, email, fkUnidade as UnidadeID, permissao FROM usuario WHERE email = '${email}' AND senha = '${senha}';

-- Ver se o usuário está cadastrado
SELECT email FROM usuario;

-- Ver o que está crítico para a KPI
SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
        JOIN sensor sn ON s.idSetor = sn.fkSetor
        JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.qtdGasVazado >= 60.0;

-- Ver os que estão seguros para a KPI
SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
		JOIN sensor sn ON s.idSetor = sn.fkSetor
		LEFT JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.idMedicao IS NULL;

-- Ver os que estão em alerta para a KPI
SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
        JOIN sensor sn ON s.idSetor = sn.fkSetor
        JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.qtdGasVazado > 0.0 AND m.qtdGasVazado < 60.0;

-- Puxar dados para a dashboard (Gráfico de barras)
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

-- Puxar dados para a dashboard (Gráfico de linha)
SELECT DATE_FORMAT(dtComecoVazamento, '%H:%i') AS horario, qtdGasVazado
    FROM medicao ORDER BY dtComecoVazamento;

-- Puxar dados para a dashboard (Gráfico de Pizza)
SELECT COUNT(dtcomecoVazamento) AS 'Quantidade', setor.nome AS 'Setor' FROM medicao JOIN sensor ON fkSensor = idSensor JOIN setor ON fkSetor = idSetor WHERE dtComecoVazamento like '_____${mes}%' GROUP BY setor.nome;

-- Model da empresa

-- Select para verificar a unidade 
SELECT idUnidade, codigo_ativacao FROM unidade;

-- Criação dos views:
CREATE VIEW logarUsuario AS 
SELECT idUsuario, nome, email, fkUnidade as UnidadeID, permissao FROM usuario;

CREATE VIEW validacaoLogado AS 
SELECT email FROM usuario;

CREATE VIEW criticoKPI AS 
SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
        JOIN sensor sn ON s.idSetor = sn.fkSetor
        JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.qtdGasVazado >= 60.0;

CREATE VIEW seguroKPI AS 
SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
		JOIN sensor sn ON s.idSetor = sn.fkSetor
		LEFT JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.idMedicao IS NULL;

CREATE VIEW alertaKPI AS 
SELECT DISTINCT s.nome AS nome_setor
        FROM setor s
        JOIN sensor sn ON s.idSetor = sn.fkSetor
        JOIN medicao m ON sn.idSensor = m.fkSensor
        WHERE m.qtdGasVazado > 0.0 AND m.qtdGasVazado < 60.0;

CREATE VIEW dadosBarra AS 
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

CREATE VIEW dadosLinha AS
SELECT DATE_FORMAT(dtComecoVazamento, '%H:%i') AS horario, qtdGasVazado
    FROM medicao ORDER BY dtComecoVazamento;

ALTER VIEW dadosPizza AS
SELECT COUNT(dtcomecoVazamento) AS 'Quantidade', setor.nome AS 'Setor', dtComecoVazamento
    FROM medicao 
    JOIN sensor ON fkSensor = idSensor 
    JOIN setor ON fkSetor = idSetor 
    GROUP BY setor.nome, dtComecoVazamento;

-- Testes dos Views
SELECT * FROM logarUsuario;

SELECT * FROM validacaoLoga1do;

SELECT * FROM criticoKPI;

SELECT * FROM seguroKPI;

SELECT * FROM alertaKPI;

SELECT * FROM dadosBarra;

SELECT * FROM dadosLinha;

SELECT * FROM dadosPizza WHERE dtComecoVazamento like '_____11%' GROUP BY setor.nome;

SELECT Quantidade, Setor
FROM dadosPizza
WHERE dtComecoVazamento LIKE '_____11%'
GROUP BY Setor;

-- Dados pizza não foi

SELECT 
    fkSensor, 
    COUNT(*) AS total_vazamentos
FROM (
    SELECT 
        m1.idMedicao, 
        m1.fkSensor,
        m1.dtComecoVazamento,
        -- Verifica a diferença em minutos entre a medição atual e a anterior
        IF(
            TIMESTAMPDIFF(MINUTE, m2.dtComecoVazamento, m1.dtComecoVazamento) > 1, 
            1, 0
        ) AS novo_vazamento
    FROM 
        medicao m1
    LEFT JOIN 
        medicao m2 ON m1.fkSensor = m2.fkSensor 
                  AND m1.dtComecoVazamento > m2.dtComecoVazamento
    WHERE 
        NOT EXISTS (
            SELECT 1
            FROM medicao m3
            WHERE m3.fkSensor = m1.fkSensor
            AND TIMESTAMPDIFF(MINUTE, m3.dtComecoVazamento, m1.dtComecoVazamento) <= 1
            AND m3.idMedicao <> m1.idMedicao
        )
) AS vazamentos
GROUP BY fkSensor;

DELIMITER $$

CREATE PROCEDURE ABCD()
BEGIN
    DECLARE a INT DEFAULT 1;
    DECLARE dtComecoVazamento1 DATETIME;
    DECLARE fkSensor1 INT;
    DECLARE dtComecoVazamento2 DATETIME;
    DECLARE fkSensor2 INT;
    DECLARE maxId INT;
    DECLARE quantidadeMes INT;

    SELECT MAX(idMedicao) INTO maxId FROM medicao;
    
    loopSimples: LOOP
        SELECT dtComecoVazamento, fkSensor 
        INTO dtComecoVazamento1, fkSensor1
        FROM medicao 
        WHERE idMedicao = a;

        SELECT dtComecoVazamento, fkSensor 
        INTO dtComecoVazamento2, fkSensor2
        FROM medicao 
        WHERE idMedicao = a+1;
        
        SET quantidadeMes = IF(
            TIMESTAMPDIFF(dtComecoVazamento1, dtComecoVazamento2) > 1, 
            1, 0
        );
        
        SET a = a + 1;

        IF a > maxId THEN
            LEAVE loopSimples;
        END IF;

    END LOOP loopSimples;
END $$

call ABCD;

