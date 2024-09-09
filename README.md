# VZND (VazaNada) - Sistema de Detecção de Vazamentos de Gás

## Descrição

O projeto **VZND (VazaNada)** visa desenvolver um sistema de monitoramento de vazamentos de gás em gasodutos, com a utilização de sensores de gás MQ-2 para detecção e uma aplicação web para visualização e alertas. O sistema ajudará a reduzir os riscos de acidentes e vazamentos em gasodutos, melhorando a segurança e diminuindo as perdas financeiras associadas.

## Objetivo

Entregar um sistema web integrado com sensores de gás em gasodutos para:
- Localizar vazamentos
- Mostrar alertas
- Exibir gráficos e estatísticas relevantes

## Justificativa

Com a instalação de sensores e a implementação do sistema, o objetivo é reduzir os riscos e prejuízos associados a vazamentos de gás em até 90%.

## Escopo

1. **Instalação dos Sensores**: Implementação de sensores MQ-2 em pontos estratégicos dos gasodutos.
2. **Desenvolvimento da API**: API para coleta de dados dos sensores e envio para o banco de dados.
3. **Desenvolvimento da Aplicação Web**: Site com dashboard para acompanhamento dos dados dos sensores.
4. **Banco de Dados**: MySQL para armazenamento e consulta dos dados coletados.
5. **Site Institucional**: Informações sobre a empresa e a solução.

## Para este projeto utilizaremos:
- **Front-End**: HTML, JavaScript
- **Banco de Dados**: MySQL
- **Hardware**: Sensor MQ-2

## Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

### Tabela `Cadastro`
Armazena informações das empresas cadastradas.

```sql
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
```

```sql
### Tabela `Sensor`
Armazena informações dos sensores cadastradas.
CREATE TABLE Sensor (
    IdSensor INT PRIMARY KEY AUTO_INCREMENT,
    longitude DECIMAL(11, 8) NOT NULL,
    latitude DECIMAL(11, 8) NOT NULL,
    dt_instalacao DATE NOT NULL,
    ultima_manutencao DATE NOT NULL
);
```
### Tabela `Registro`
Armazena os registros de vazamentos.
```sql
CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    idSensor INT NOT NULL,
    data_hora DATETIME NOT NULL,
    porcentagem DECIMAL(5, 2) NOT NULL
);
```
