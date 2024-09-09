# VZND (VazaNada) - Sistema de Detecção de Vazamentos de Gás

## Descrição

O projeto **VZND (VazaNada)** visa desenvolver um sistema de monitoramento de vazamentos de gás em gasodutos, com a utilização de sensores de gás para detecção e uma aplicação web para visualização e alertas. O sistema ajudará a reduzir os riscos de acidentes e vazamentos em gasodutos, melhorando a segurança e diminuindo as perdas financeiras associadas.

<p align="center">
  <img src="https://i.postimg.cc/BZTd1G9n/Vz.png" alt="Descrição da Imagem" width="500"/>
</p>


## Objetivo

Entregar um sistema web integrado com sensores de gás em gasodutos para:
- Localizar vazamentos
- Mostrar alertas
- Exibir gráficos e estatísticas relevantes

## Justificativa

Com a instalação de sensores e a implementação do sistema, o objetivo é reduzir o tempo de detecção de vazamentos de gás em até 90%.

## Escopo

1. **Instalação dos Sensores**: Implementação de sensores em pontos estratégicos dos gasodutos.
2. **Desenvolvimento da API**: API para coleta de dados dos sensores e envio para o banco de dados.
3. **Desenvolvimento da Aplicação Web**: Site com dashboard para acompanhamento dos dados dos sensores.
4. **Banco de Dados**: MySQL para armazenamento e consulta dos dados coletados.
5. **Site Institucional**: Informações sobre a empresa e a solução.

## Para este projeto utilizaremos:
- **Front-End**: HTML, JavaScript
- **Banco de Dados**: MySQL
- **Hardware de prototipação**: Sensor MQ-2
- **Back-end**: NodeJS

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

### Tabela `Sensor`
Armazena informações dos sensores cadastradas.
```sql
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


## Simulador Financeiro

# Código de Exemplo
HTML e JavaScript para Calculadora de Economia
O código HTML e JavaScript abaixo permite estimar a economia com a solução VZND.


**HTML**
```html
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculadora VazaNada</title>
</head>
<body>
    <h1>Bem vindo!</h1>
    <h2>Preencha os campos abaixo para estimar sua economia utilizando a solução da VZND:</h2>
    <!-- Inputs para dados do usuário -->
    ...
    <button onclick="calcular()">Calcular</button>
    <br>
    <br>
    <div id="div_mensagem"></div>
</body>
</html>
```

**JavaScript**
```javascript
function calcular() {
    var qtdVazamentos = Number(ipt_qtdVazamentos.value);
    var maiorVazamento = Number(ipt_maiorVazamento.value);
    var menorVazamento = Number(ipt_menorVazamento.value);
    var maiorTempo = Number(ipt_maiorTempo.value) / 60; // Conversão de min para horas
    var menorTempo = Number(ipt_menorTempo.value) / 60; // Conversão de min para horas
    var custoGasMCubico = Number(ipt_custo_gas.value);

    if (qtdVazamentos == 0 || maiorVazamento == 0 || menorVazamento == 0 || maiorTempo == 0 || menorTempo == 0) {
        alert("Preencha todos os campos!");
    } else if (qtdVazamentos < 0 || maiorVazamento < 0 || menorVazamento < 0 || maiorTempo < 0 || menorTempo < 0) {
        alert("Os valores não podem ser negativos!");
    } else if (maiorVazamento < menorVazamento) {
        alert("O maior vazamento não pode ser menor que o menor vazamento!");
    } else if (maiorTempo < menorTempo) {
        alert("O menor tempo não pode ser maior que o maior tempo!");
    } else {
        var mediaQuantidadeVazadoPorHora = (maiorVazamento + menorVazamento) / 2;
        var mediaTempo = (maiorTempo + menorTempo) / 2;
        var mediaDePerdaPorVazamento = mediaQuantidadeVazadoPorHora * mediaTempo;
        var mediaDeCustoPorVazamento = mediaDePerdaPorVazamento * custoGasMCubico;
        var mediaAnual = mediaDePerdaPorVazamento * qtdVazamentos;
        var mediaMensal = mediaAnual / 12;
        var mediaCustoAnual = mediaDeCustoPorVazamento * qtdVazamentos;
        var mediaCustoMensal = mediaCustoAnual / 12;

        var mediaTempoDesconto = mediaTempo * 0.1;
        var mediaDePerdaPorVazamentoDesconto = mediaQuantidadeVazadoPorHora * mediaTempoDesconto;
        var mediaCustoPorVazamentoDesconto = mediaDePerdaPorVazamentoDesconto * custoGasMCubico;
        var mediaCustoAnualDesconto = mediaCustoPorVazamentoDesconto * qtdVazamentos;
        var mediaCustoMensalDesconto = mediaCustoAnualDesconto / 12;

        div_mensagem.innerHTML = `
            <b>Você perdeu aproximadamente:</b> 
            <ul>
                <li>💸 ${mediaCustoAnual.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })} nos últimos 12 meses.</li>
                <li>📅 Uma média mensal de ${mediaCustoMensal.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })}</li>
                <li>🔄 Perdendo aproximadamente ${mediaAnual.toLocaleString()} m³ de gás por ano</li>
                <li>📉 Perdendo aproximadamente ${mediaMensal.toLocaleString()} m³ de gás por mês</li>
            </ul>
            
            <b>Com a solução da VZ<span style="color: #5CE1E6">ND</span>, você poderia:</b>
            <ul
```


## Prototipação com Arduino e Sensor MQ-2

### Visão Geral

Este projeto utiliza um Arduino e um sensor de gás MQ-2 para prototipação de sistemas de monitoramento em gasodutos. O sensor MQ-2 é projetado para detectar gases como metano, propano, monóxido de carbono e fumaça, tornando-o útil para várias aplicações de monitoramento de gás.

### Componentes Utilizados

- **Arduino Uno**: Placa de prototipagem baseada em microcontrolador, amplamente utilizada para desenvolver e testar projetos eletrônicos.
- **Sensor MQ-2**: Sensor de gás capaz de detectar diferentes tipos de gases e fumaça. Ideal para a medição da qualidade do ar.

### Objetivo

A prototipação com o Arduino e o sensor MQ-2 visa criar um sistema inicial para monitoramento e análise de gás. Este sistema permitirá a leitura dos níveis de gases no ambiente e a visualização dessas informações, proporcionando uma base para o desenvolvimento da aplicação.

### Como Funciona

1. **Conexão do Hardware**: O sensor MQ-2 é conectado à placa Arduino. Os pinos do sensor são conectados às entradas analógicas e digitais do Arduino para leitura dos dados de gás.
2. **Programação do Arduino**: O Arduino é programado para ler os valores do sensor MQ-2, processar esses dados e, em seguida, exibir essas imagens em um gráfico através do arduino IDE.
3. **Testes e Validação**: Durante a fase de prototipação, o sistema é testado em diferentes condições para validar a precisão e a resposta do sensor MQ-2.

### Código de Exemplo

Aqui está um exemplo básico de código para começar a prototipação:

```cpp
int mq2Pin = A0; // Pino analógico ao qual o MQ-2 está conectado
int mq2Value = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  mq2Value = analogRead(mq2Pin); // Leitura do valor do sensor MQ-2
  Serial.print("Valor do MQ-2: ");
  Serial.println(mq2Value);
  delay(1000); // Espera de 1 segundo antes da próxima leitura
}


