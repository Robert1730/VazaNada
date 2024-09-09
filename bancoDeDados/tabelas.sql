CREATE DATABASE vazanada;
USE vazanada;

CREATE TABLE Cadastro (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
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

CREATE TABLE Sensor (
    IdSensor INT PRIMARY KEY AUTO_INCREMENT,
    longitude DECIMAL(11, 8) NOT NULL,
    latitude DECIMAL(11, 8) NOT NULL,
    dt_instalacao DATE NOT NULL,
    ultima_manutencao DATE NOT NULL
);



CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    sensor INT NOT NULL,
    data_hora DATETIME NOT NULL,
    porcentagem DECIMAL(5, 2) NOT NULL
);

INSERT INTO Cadastro (razao_social, cnpj, email, senha, cep, logradouro, numero, cidade, uf complemento, telefone, responsavel) VALUES 
('', '')

INSERT INTO Sensor (longitude, latitude, dt_instalacao, ultima_manutencao) VALUES 
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01'),
(-23.5505199, -46.6333094, '2020-01-01', '2020-01-01');



