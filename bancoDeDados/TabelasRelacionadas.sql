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

INSERT INTO Cadastro (razao_social, cnpj, email, senha, cep, logradouro, numero, cidade, uf, complemento, telefone, responsavel) VALUES 
('Petrogás', '12345678910234', 'petrogás@petrogás.com', 'Hfch2fJ#$', '12345678', 'Rua dos Petroleiros', 123, 'São Paulo', 'SP', 'Sala 1', '11987654321', 'João da Silva'),
('Gás & Cia', '82736479123475', 'gas&cia@gas&cia.com', 'Yfjau2fJ&', '12345678', 'Rua dos Gaseiros', 12, 'São Paulo', 'SP', null, '11987664381', 'Marcos António'),
('Gás do Brasil', '28374820193847', 'brasil@gas.com', 'UvhmfKJ%', '12345678', 'Rua dos Brasileiros', 123, 'São Paulo', 'SP', '3 andar', '11836654321', 'Osvaldo Ramos');



CREATE TABLE Login (
idLogin int primary key auto_increment,
email varchar(255) NOT NULL,
senha varchar(255) NOT NULL,
fkLogin INT UNIQUE,
CONSTRAINT fkLoginCadastro FOREIGN KEY (fkLogin)
REFERENCES Cadastro(idEmpresa)
);

INSERT INTO Login (email, senha, fklogin) values
('petrogás@petrogás.com', 'Hfch2fJ#$', 3),
('gas&cia@gas&cia.com', 'Yfjau2fJ&', 1),
('brasil@gas.com', 'UvhmfKJ%', 2);

INSERT INTO Login (email, senha, fklogin) values
('petrogás@petrogá.com', 'afch2fJ#$', 3);


select * from login;

SELECT idEmpresa, c.email, c.senha, l.senha, l.email,l.idLogin, l.fkLogin from login as l join cadastro as c on fkLogin = idEmpresa;

































CREATE TABLE usuario (
	id INT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE comida (
	id INT PRIMARY KEY,
    nomeComida VARCHAR(45),
    preco DECIMAL(5,2)
);

CREATE TABLE pedido (
	id INT PRIMARY KEY auto_increment,
    
    fkUsuario INT,
    fkComida INT,
    hora_pedido DATETIME,
    
	CONSTRAINT fkPedidoUsuario FOREIGN KEY(fkUsuario) REFERENCES usuario (id),
    CONSTRAINT fkPedidoComida FOREIGN KEY(fkComida) REFERENCES comida(id)
);
