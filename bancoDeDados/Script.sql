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
) AUTO_INCREMENT 1000;

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
dtInstalacao DATETIME,
dtUltimaManutencao DATETIME,
fkSetor INT,
CONSTRAINT fkSensorSetor 
    FOREIGN KEY (fkSetor)
        REFERENCES setor(idSetor)
) AUTO_INCREMENT 1000;

CREATE TABLE medicao (
idMedicao INT PRIMARY KEY AUTO_INCREMENT,
qtdGasVazado FLOAT,
dtComecoVazamento DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
CONSTRAINT fkMedicaoSensor 
    FOREIGN KEY (fkSensor)
        REFERENCES sensor(idSensor)
) AUTO_INCREMENT 1000;

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
email VARCHAR(255),
senha VARCHAR(255), 
fkUnidade INT,
CONSTRAINT fkUnidadeUsuario 
    FOREIGN KEY (fkUnidade)
        REFERENCES unidade(idUnidade)
)AUTO_INCREMENT 1000;

-- CREATE TABLE login (
-- idLogin INT PRIMARY KEY AUTO_INCREMENT,
-- dtHrAcesso DATETIME,
-- dtHrSaida DATETIME,
-- fkUsuario INT,
-- CONSTRAINT fkLoginUsuario 
--     FOREIGN KEY (fkUsuario)
--         REFERENCES usuario(idUsuario)
-- );

SHOW TABLES;

-- Descrição das tabelas:
DESC empresa;
DESC unidade;
DESC setor;
DESC sensor;
DESC medicao;
DESC usuario;

-- Inserção da empresa administradora
INSERT INTO empresa (idEmpresa, razao_social, nome, responsavel, telefone) VALUES 
(1, 'VazaNada', 'Petrobras', 'Robert Ferreira de Souza', '1194456789');

-- Inserção da empresa exemplo
INSERT INTO empresa (razao_social, nome, responsavel, telefone) VALUES 
('Petrobras S.A.', 'Petrobras', 'Roberto da Silva', '2134456789');

INSERT INTO unidade (idUnidade, nome, logradouro, numero, bairro, cidade, estado, cep, fkEmpresa) VALUES 
(1,'Matrix', 'Rua Augusta', '1730', 'Jardins', 'São Paulo', 'SP', '20031-080', 1),
(DEFAULT, 'Unidade Rio de Janeiro', 'Avenida República do Chile', '65', 'Centro', 'Rio de Janeiro', 'RJ', '20031-912', 1000);

-- Inserção do usuário administrador
INSERT INTO usuario (idUsuario, nome, email, senha, fkUnidade) VALUES 
(1, 'Robert Ferreira de Souza', 'robert.souza@vazanada.com', '1404Rt05@', 1);

-- Inserção dos outros usuários
INSERT INTO usuario (nome, email, senha, fkUnidade) VALUES 
('Juliana Ribeiro', 'juliana.ribeiro@petrobras.com', 'senhaPetro@456', 1000);

-- INSERT INTO login (dtHrAcesso, dtHrSaida, fkUsuario) VALUES 
-- ('2024-11-27 08:00:00', '2024-11-27 12:00:00', 1),
-- ('2024-11-27 13:00:00', '2024-11-27 17:00:00', 2);

INSERT INTO setor (nome, descricao, fkUnidade) VALUES 
('Setor de Medição RJ', 'Monitoramento de gasodutos na unidade RJ', 1),
('Setor de Inspeção RJ', 'Inspeção de segurança na unidade RJ', 1);

INSERT INTO sensor (nome, dtInstalacao, dtUltimaManutencao, fkSetor) VALUES 
('Sensor MQ2-RJ1', '2023-02-10 10:00:00', '2024-02-09 10:00:00', 1),
('Sensor MQ2-SP1', '2023-03-15 11:00:00', '2024-03-14 11:00:00', 2);

INSERT INTO medicao (qtdGasVazado, dtComecoVazamento, fkSensor) VALUES 
(4.1, '2024-11-25 09:45:00', 1),
(75, '2024-11-26 14:20:00', 2);	

SELECT * FROM empresa;
SELECT * FROM unidade;
SELECT * FROM setor;
SELECT * FROM sensor;
SELECT * FROM medicao;
SELECT * FROM usuario;
SELECT * FROM login;

-- Criando view para visualizar o setor que está em estado crítico (KPI):
create view vw_Setor_Critico as 
select setor.nome as 'Setor' from medicao
join sensor
on idSensor = fkSensor
join setor
on idSetor = fkSetor
where medicao.qtdGasVazado >= 75;

SELECT * FROM vw_Setor_Critico;

-- Terminar de arrumar o Script urgente
