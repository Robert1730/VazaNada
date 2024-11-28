create database vazaNada;
use vazaNada;

create table usuario (
idUsuario int primary key auto_increment,
nome varchar(45),
email varchar(255),
senha varchar(255),
fkUnidade int,
foreign key fkUnidadeUsuario (fkUnidade)
references unidade(idUnidade)
);

create table login (
idLogin int primary key auto_increment,
dtHrAcesso datetime,
dtHrSaida datetime,
fkUsuario int,
constraint fkLoginUsuario foreign key (fkUsuario)
references usuario(idUsuario)
);

create table empresa (
idEmpresa int primary key auto_increment,
razao_social varchar(255),
nome varchar(255),
responsavel varchar(80),
telefone varchar(11)
);

create table unidade (
idUnidade int primary key auto_increment,
nome varchar(255),
logradouro varchar(100),
numero varchar(10),
bairro varchar(100),
cidade varchar(45),
estado char(2),
cep char(9),
fkEmpresa int,
constraint fkEmpresaUnidade foreign key (fkEmpresa) 
references empresa(idEmpresa),
codigo_ativacao varchar(45)
);

create table setor (
idSetor int primary key auto_increment,
nome varchar(60),
descricao varchar(100),
fkUnidade int,
constraint fkSetorUnidade foreign key (fkUnidade)
references unidade(idUnidade)
);

create table sensor (
idSensor int primary key auto_increment,
nome varchar(45),
dtInstalacao datetime,
dtUltimaManutencao datetime,
fkSetor int,
constraint fkSensorSetor foreign key (fkSetor)
references setor(idSetor)
);

create table medicao (
idMedicao int primary key auto_increment,
qtdGasVazado float,
dtComecoVazamento datetime,
fkSensor int,
constraint fkMedicaoSensor foreign key (fkSensor)
references sensor(idSensor)
);

show tables;

INSERT INTO empresa (razao_social, nome, responsavel, telefone) VALUES 
('Petrobras S.A.', 'Petrobras', 'Roberto da Silva', '2134456789'),
('Shell Brasil Ltda', 'Shell', 'Fernanda Costa', '1123456789');

INSERT INTO unidade (nome, logradouro, numero, bairro, cidade, estado, cep, fkEmpresa) VALUES 
('Unidade Rio de Janeiro', 'Avenida República do Chile', '65', 'Centro', 'Rio de Janeiro', 'RJ', '20031-912', 1),
('Unidade São Paulo', 'Avenida das Nações Unidas', '12551', 'Brooklin Novo', 'São Paulo', 'SP', '04578-000', 2);

INSERT INTO usuario (nome, email, senha, fkUnidade) VALUES 
('Carlos Almeida', 'carlos.almeida@petrobras.com', 'senhaPetro@123', 1),
('Juliana Ribeiro', 'juliana.ribeiro@shell.com', 'senhaShell456', 2);

INSERT INTO login (dtHrAcesso, dtHrSaida, fkUsuario) VALUES 
('2024-11-27 08:00:00', '2024-11-27 12:00:00', 1),
('2024-11-27 13:00:00', '2024-11-27 17:00:00', 2);

INSERT INTO setor (nome, descricao, fkUnidade) VALUES 
('Setor de Monitoramento RJ', 'Monitoramento de gasodutos na unidade RJ', 1),
('Setor de Inspeção SP', 'Inspeção de segurança na unidade SP', 2);

INSERT INTO sensor (nome, dtInstalacao, dtUltimaManutencao, fkSetor) VALUES 
('Sensor MQ2-RJ1', '2023-02-10 10:00:00', '2024-02-09 10:00:00', 1),
('Sensor MQ2-SP1', '2023-03-15 11:00:00', '2024-03-14 11:00:00', 2);

INSERT INTO medicao (qtdGasVazado, dtComecoVazamento, fkSensor) VALUES 
(4.1, '2024-11-25 09:45:00', 1),
(3.7, '2024-11-26 14:20:00', 2);	

select * from empresa;
select * from unidade;
select * from setor;
select * from sensor;
select * from medicao;
select * from usuario;
select * from login;

desc empresa;

select * from unidade join empresa
on idEmpresa = fkEmpresa;

select * from vw_user_nome_email_codigo;

-- 1 criando view: email
create view vw_Usuario_email as 
select email from usuario;

-- 1. vendo view: email
select * from vw_Usuario_email;

-- 2 criando view: codigo
create view vw_Unidade_codigo as
select codigo_ativacao from unidade;

-- 2. vendo view: codigo
select * from vw_Unidade_codigo;

-- 3 criando view: nome, senha do usuario
create view vw_Usuario_nome_senha as 
select nome as Nome_Usuario, senha as Senha_Usuario from usuario;

-- 3. vendo view: nome, senha
select * from vw_Usuario_nome_senha;











