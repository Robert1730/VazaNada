-- Criação do banco de dados

CREATE DATABASE VazaNada;
USE VazaNada;

-- Começo

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(150) NOT NULL,
nome VARCHAR(255) NOT NULL,
responsavel VARCHAR(80) NOT NULL,
telefone CHAR(11) NOT NULL
);

-- Solução

CREATE TABLE Unidade (
idUnidade INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
logradouro VARCHAR(100) NOT NULL,
numero VARCHAR(10) NOT NULL,
bairro VARCHAR(100) NOT NULL,
estado VARCHAR(100) NOT NULL,
cep CHAR(8) NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaUnidade 
	FOREIGN KEY (fkEmpresa) 
		REFERENCES empresa (idEmpresa)
);

CREATE TABLE Setor (
idSetor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
descrição VARCHAR(100) NOT NULL,
fkUnidade INT NOT NULL,
CONSTRAINT fkSetorUnidade 
	FOREIGN KEY (fkUnidade) 
		REFERENCES empresa (idEmpresa)
);

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
dtInstalação DATETIME NOT NULL,
dtÚltimaManutenção DATETIME NOT NULL,
fkSetor INT NOT NULL, 
CONSTRAINT fkSensorSetor 
	FOREIGN KEY (fkSetor) 
		REFERENCES Setor (idSetor)
);

CREATE TABLE Medição (
idMedição INT PRIMARY KEY AUTO_INCREMENT,
qtdGásVazado INT NOT NULL,
dtComeçoVazamento DATETIME NOT NULL,
fkSensor INT NOT NULL, 
CONSTRAINT fkMediçãoSensor 
	FOREIGN KEY (fkSensor) 
		REFERENCES Sensor (idSensor)
);

-- Site

CREATE TABLE Usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
email VARCHAR(255) NOT NULL,
senha VARCHAR(255) NOT NULL,
fkEmpresa INT NOT NULL, 
CONSTRAINT fkUsuarioEmpresa 
	FOREIGN KEY (fkEmpresa) 
		REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Login (
idLogin INT PRIMARY KEY AUTO_INCREMENT,
dtHrAcesso DATETIME,
dtHrSaída DATETIME,
fkUsuario INT,
CONSTRAINT fkLoginUsuario
	FOREIGN KEY (fkUsuario)
		REFERENCES Usuario (idUsuario)
);

