CREATE DATABASE vazanada;
USE vazanada;

CREATE TABLE Cadastro (
    idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(150) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    email VARCHAR(80) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cep CHAR(8) NOT NULL,
    logradouro VARCHAR(200) NOT NULL,
    numero INT NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf CHAR(2) NOT NULL,
    complemento VARCHAR(40),
    telefone VARCHAR(11) NOT NULL,
    responsavel VARCHAR(80) NOT NULL
);

CREATE TABLE Login (
idLogin int primary key auto_increment,
email varchar(255) NOT NULL,
senha varchar(255) NOT NULL,
fkCadastro INT UNIQUE,
CONSTRAINT fkEmpresaCadastro FOREIGN KEY (fkCadastro)
REFERENCES Cadastro(idCadastro)
);

CREATE TABLE Sensor (
    IdSensor INT PRIMARY KEY AUTO_INCREMENT,
    longitude DECIMAL(11, 8) NOT NULL,
    latitude DECIMAL(11, 8) NOT NULL,
    dt_instalacao DATE NOT NULL,
    ultima_manutencao DATE NOT NULL
);

CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    idSensor INT NOT NULL,
    data_hora DATETIME NOT NULL,
    porcentagem DECIMAL(5, 2) NOT NULL
);

INSERT INTO Cadastro (razao_social, cnpj, email, senha, cep, logradouro, numero, cidade, uf, complemento, telefone, responsavel) VALUES 
('Petrogás', '12345678910234', 'petrogás@petrogás.com', 'Hfch2fJ#$', '12345678', 'Rua dos Petroleiros', 123, 'São Paulo', 'SP', 'Sala 1', '11987654321', 'João da Silva'),
('Gás & Cia', '82736479123475', 'gas&cia@gas&cia.com', 'Yfjau2fJ&', '12345678', 'Rua dos Gaseiros', 12, 'São Paulo', 'SP', null, '11987664381', 'Marcos António'),
('Gás do Brasil', '28374820193847', 'brasil@gas.com', 'UvhmfKJ%', '12345678', 'Rua dos Brasileiros', 123, 'São Paulo', 'SP', '3 andar', '11836654321', 'Osvaldo Ramos');

INSERT INTO Sensor (longitude, latitude, dt_instalacao, ultima_manutencao) VALUES 
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5648327, -46.6548790, '2020-02-15', '2020-03-01'),
(-23.5565810, -46.6357410, '2020-03-10', '2020-04-20'),
(-23.5472578, -46.6415560, '2020-04-25', '2020-05-15'),
(-23.5536790, -46.6185690, '2020-05-30', '2020-07-10'),
(-23.5678490, -46.6201500, '2020-06-15', '2020-08-25'),
(-23.5723440, -46.6367400, '2020-07-20', '2020-09-05'),
(-23.5490260, -46.6297810, '2020-08-10', '2020-10-15'),
(-23.5529710, -46.6447820, '2020-09-25', '2020-11-01'),
(-23.5489020, -46.6376430, '2020-10-05', '2020-12-10');


INSERT INTO Registro (idSensor, data_hora, porcentagem) VALUES 
(1, '2020-01-01 00:00:00', 5.0),
(1, '2020-01-01 00:00:10', 5.2),
(1, '2020-01-01 00:00:20', 6.0),
(1, '2020-01-01 00:00:30', 6.8),
(1, '2020-01-01 00:00:40', 7.3),
(1, '2020-01-01 00:00:50', 8.1),
(1, '2020-01-01 00:01:00', 8.7),
(1, '2020-01-01 00:01:10', 9.5),
(1, '2020-01-01 00:01:20', 10.2),
(1, '2020-01-01 00:01:30', 11.0),
(1, '2020-01-01 00:01:40', 11.8),
(1, '2020-01-01 00:01:50', 12.5),
(1, '2020-01-01 00:02:00', 13.2),
(1, '2020-01-01 00:02:10', 13.9),
(1, '2020-01-01 00:02:20', 14.8),
(1, '2020-01-01 00:02:30', 15.5),
(1, '2020-01-01 00:02:40', 16.1),
(1, '2020-01-01 00:02:50', 16.9),
(1, '2020-01-01 00:03:00', 17.6),
(1, '2020-01-01 00:03:10', 18.4),
(1, '2020-01-01 00:03:20', 19.0),
(1, '2020-01-01 00:03:30', 19.8),
(1, '2020-01-01 00:03:40', 20.5),
(1, '2020-01-01 00:03:50', 21.1),
(1, '2020-01-01 00:04:00', 21.9),
(1, '2020-01-01 00:04:10', 22.6),
(1, '2020-01-01 00:04:20', 23.3),
(1, '2020-01-01 00:04:30', 24.1),
(1, '2020-01-01 00:04:40', 24.8),
(1, '2020-01-01 00:04:50', 25.6),
(1, '2020-01-01 00:05:00', 26.3);

INSERT INTO Login (email, senha, fkCadastro) values
('petrogás@petrogás.com', 'Hfch2fJ#$', 1),
('gas&cia@gas&cia.com', 'Yfjau2fJ&', 2),
('brasil@gas.com', 'UvhmfKJ%', 3);

SELECT CONCAT('Bem vindo ', responsavel, '! O cadastro da empresa ', razao_social, ' foi realizado com sucesso. Aproveite!!') AS 'Boas vindas' FROM Cadastro WHERE idCadastro = 2;
SELECT * FROM Cadastro WHERE uf = 'SP';

SELECT * FROM Sensor WHERE ultima_manutencao < '2020-04-20' ORDER BY ultima_manutencao;
SELECT * FROM Sensor WHERE longitude = -23.5536790 && latitude = -46.6185690;

SELECT * FROM Registro WHERE porcentagem > 20 ORDER BY data_hora DESC;
SELECT porcentagem FROM Registro WHERE idSensor = 1;

select * from login;

SELECT idCadastro, c.email, c.senha, l.senha, l.email, idLogin, l.fkCadastro from login as l join cadastro as c on fkCadastro = idCadastro;
