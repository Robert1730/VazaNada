
function Resetar() {

    location.reload();

}

function Economia() {

    var vazamentos = Number(document.getElementById("ipt_vazamentos").value)
    var duraçao_vazamento = Number(document.getElementById("ipt_duraçao_vazamento").value)
    var tempo_detecçao = Number(document.getElementById("ipt_tempo_detecçao").value)
    var perdeu_gas = Number(document.getElementById("ipt_perdeu_gas").value)

    var novo_tempo = Math.ceil(tempo_detecçao * 0.1)
    var nova_duraçao = Math.ceil(duraçao_vazamento - (tempo_detecçao - novo_tempo))
    var nova_duracao_porcentagem = (nova_duraçao / duraçao_vazamento) * 100
    var nova_duracao_porcentagem_tofixed = nova_duracao_porcentagem.toFixed(2)

    var perdeu_no_mes = perdeu_gas * duraçao_vazamento * vazamentos
    var novo_perdeu_no_mes = perdeu_gas * nova_duraçao * vazamentos

    var economia = perdeu_no_mes - novo_perdeu_no_mes
    var economia_porcentagem = (economia / perdeu_no_mes) * 100
    var economia_porcentagem_ceil = Math.ceil(economia_porcentagem)

    div_validarVazamento.innerHTML = ``
    div_validarTempo.innerHTML = ``
    div_validarDeteccao.innerHTML = ``
    div_validarPerda.innerHTML = ``


    if (vazamentos <= 0) {

        div_validarVazamento.innerHTML = `⛔ Insira um valor válido (Maior que 0) `;

    } 
    
    if( duraçao_vazamento <= 0) {

        div_validarTempo.innerHTML = `⛔ Insira um valor válido (Maior que 0) `;

    } 
    
    if( tempo_detecçao <= 0 ) {

        div_validarDeteccao.innerHTML = `⛔ Insira um valor válido (Maior que 0) `;

    } 
    
    if( perdeu_gas <= 0) {

        div_validarPerda.innerHTML = `⛔ Insira um valor válido (Maior que 0) `;

    } 
    
    if (vazamentos > 0 && duraçao_vazamento > 0 && tempo_detecçao > 0 && perdeu_gas > 0) {


        // CAIXA ECONOMIA QUE SERÁ EXIBIDA PARA O CLIENTE:
        caixa_simulador.innerHTML = `

    <h1 style="color: white;">Com a solução desenvolvida pela VZ<span style="color:#50FFDF">ND</span></h1>

<div class="simulador"> 
   
    <div>
        <ul class="itens">
            <h2>Baseando-se no cenário da sua empresa, nossa solução te traz:</h2>

            <h2>Uma redução de até <span style="color:#50FFDF">90%</span> no tempo de detecção de vazamento de gás.</h2>

            <h3>Com isso, o <span style="color:#50FFDF">novo</span> cenário da sua empresa com a solução VZ<span style="color:#50FFDF">ND</span> possibilita:</h3>

            <li>Vazamentos durando no máximo <span style="color:#50FFDF"><b>${nova_duraçao} min</b></span> (${nova_duracao_porcentagem_tofixed}% mais curtos) 🕗</li> 
            <li>Detectar um vazamento em <span style="color:#50FFDF"><b>${novo_tempo} min</b></span> (${tempo_detecçao * 0.9} min mais eficiente) ⚡</li>
            <li>Economizar <span style="color:#50FFDF"><b>${economia} m3</b></span> de gás no mês (${economia_porcentagem_ceil}% a mais) 📈</li> 
            <li>Maior prevenção de acidentes nos gasodutos ✅</li> 
        </ul>
    </div>
        <div class="div_botao_economia">
            <a href="./faleconosco.html"><button>ADQUIRIR SOLUÇÃO</button></a>
            <button onclick="Resetar()">SIMULAR NOVAMENTE</button>
        </div>
</div>


<style>
   
.simulador {

width: 70%;
height: 70%;

}


.simulador .itens {

line-height: 2;

}

.simulador h3 {

width: 100%;

}

.div_botao_economia {

height: 100%;
width: 100%;
display: flex;
position: relative;
justify-content: space-evenly;
align-items: flex-end;
top: 18px;

}
        </style>
    `

    }
}