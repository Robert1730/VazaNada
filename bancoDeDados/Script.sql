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
('Petrobras S.A.', 'Petrobras', 'Roberto da Silva', '2134456789');

INSERT INTO unidade (nome, logradouro, numero, bairro, cidade, estado, cep, fkEmpresa) VALUES 
('Unidade Rio de Janeiro', 'Avenida República do Chile', '65', 'Centro', 'Rio de Janeiro', 'RJ', '20031-912', 1);

INSERT INTO usuario (nome, email, senha, fkUnidade) VALUES 
('Carlos Almeida', 'carlos.almeida@petrobras.com', 'senhaPetro@123', 1),
('Juliana Ribeiro', 'juliana.ribeiro@petrobras.com', 'senhaPetro@456', 1);

INSERT INTO login (dtHrAcesso, dtHrSaida, fkUsuario) VALUES 
('2024-11-27 08:00:00', '2024-11-27 12:00:00', 1),
('2024-11-27 13:00:00', '2024-11-27 17:00:00', 2);

INSERT INTO setor (nome, descricao, fkUnidade) VALUES 
('Setor de Monitoramento RJ', 'Monitoramento de gasodutos na unidade RJ', 1),
('Setor de Inspeção RJ', 'Inspeção de segurança na unidade RJ', 1);

INSERT INTO sensor (nome, dtInstalacao, dtUltimaManutencao, fkSetor) VALUES 
('Sensor MQ2-RJ1', '2023-02-10 10:00:00', '2024-02-09 10:00:00', 1),
('Sensor MQ2-SP1', '2023-03-15 11:00:00', '2024-03-14 11:00:00', 2);

INSERT INTO medicao (qtdGasVazado, dtComecoVazamento, fkSensor) VALUES 
(4.1, '2024-11-25 09:45:00', 1),
(75, '2024-11-26 14:20:00', 2);	

select * from empresa;
select * from unidade;
select * from setor;
select * from sensor;
select * from medicao;
select * from usuario;
select * from login;

desc setor;
desc sensor;
desc medicao;

-- Criando view para visualizar o setor que está em estado crítico (KPI):
create view vw_Setor_Critico as 
select setor.nome as 'Setor' from medicao
join sensor
on idSensor = fkSensor
join setor
on idSetor = fkSetor
where medicao.qtdGasVazado >= 75;

select * from vw_Setor_Critico;


















