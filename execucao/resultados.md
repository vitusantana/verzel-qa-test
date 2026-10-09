# Resultados da execução

Entrega avaliada: **VZS-142** (cupom de desconto e frete grátis), versão 2.3.0.
Ambiente: Verzel Store, Chrome e Postman, 08 e 09/10/2026. Testes manuais e exploratórios (a automação está em `automacao/`).

## Legenda

| Resultado | Significado |
|-----------|-------------|
| Passou | O resultado obtido bate com o esperado pela documentação. |
| Falhou | O resultado obtido difere do esperado. Há um bug associado (BUG-xx em `bugs/`). |
| Não aplicável | O cenário deixou de fazer sentido (ver observação). |
| Não executado | O cenário foi levantado, mas não foi executado nesta rodada. |

Bugs: [BUG-01](../bugs/BUG-01.md), [BUG-02](../bugs/BUG-02.md), [BUG-03](../bugs/BUG-03.md) e [BUG-04](../bugs/BUG-04.md). Os prints ficam em `evidencias/`, com legendas em `evidencias/README.md`.

## Cupom (01-cupom.feature)

| Cenário | Resultado | Observação | Evidência |
|---------|-----------|------------|-----------|
| CT-CUP-01 | Passou | Subtotal 239,70, desconto 23,97, frete Grátis, total 215,73. Também automatizado. | `cupom/CT-CUP-01.png`, `automacao/` |
| CT-CUP-02 | Passou | Linha da Mochila (desconto R$ 10,00, total R$ 109,90) confirmada em print; Desconto de 10% conferido sobre o subtotal (ex.: Mochila: R$ 10,00) | `cupom/CT-CUP-02.png` |
| CT-CUP-03 | Passou | Código do cupom não diferencia maiúsculas de minúsculas | `cupom/CT-CUP-03.png` |
| CT-CUP-04 | Passou | Espaço no inicio e no fim são ignorados e o cupom é aplicado com sucesso | `cupom/CT-CUP-04.png` |
| CT-CUP-05 | Passou | Código com espaço no meio. | `cupom/CT-CUP-05.png` |
| CT-CUP-06 | Passou | Utilização de cupom invalido. | `cupom/CT-CUP-06.png` |
| CT-CUP-07 | Passou | Utilização de cupom expirado | `cupom/CT-CUP-07.png` |
| CT-CUP-08 | Passou | Utilização de cupom expirado com espaço no meio | `cupom/CT-CUP-08.png` |
| CT-CUP-09 | Passou | Campo de cupom some com cupom aplicado; não dá para reaplicar o mesmo (cobre o antigo CT-CUP-11). Ver AMB-03. | `cupom/CT-CUP-09.png` |
| CT-CUP-10 | Passou | Trocar de cupom removendo o atual e recalculado sem desconto | `cupom/CT-CUP-10.png` |
| CT-CUP-11 | Não aplicável | Fundido ao CT-CUP-09. | `cupom/CT-CUP-09.png` |
| CT-CUP-12 | Passou| Sem código, nenhum desconto é aplicado e não há erro  | `cupom/CT-CUP-12.png` |
| CT-CUP-13 | Passou | Desconto é recalculado ao alterar a quantidade com cupom aplicado | `cupom/CT-CUP-13.png`|
| CT-CUP-14 | Passou | Desconto é recalculado e aparece vazio e nenhum valor negativo ou inconsistente é exibido | `cupom/CT-CUP-14.png` |

## Frete (02-frete.feature)

| Cenário | Resultado | Observação | Evidência |
|---------|-----------|------------|-----------|
| CT-FRE-01 | Passou | Frete fixo abaixo de R$ 200,00 e valor faltante informado | `frete/CT-FRE-01.png` |
| CT-FRE-02 | Falhou | Frete R$ 19,90 com subtotal R$ 200,00. **BUG-01**. Automatizado com `test.fail()`. | `frete/CT-FRE-02.png`, `automacao/CT-FRE-02-bug.png` |
| CT-FRE-03 | Falhou | 4 Garrafas: frete R$ 19,90 com subtotal R$ 200,00. **BUG-01**. | `frete/CT-FRE-03.png` |
| CT-FRE-04 | Passou | Equivalente na API (CT-API-09, P004 x4) passou. | `frete/CT-FRE-04.png` |
| CT-FRE-05 | Passou | Subtotal acima de R$ 200,00 (Jaqueta e 3 Mochilas): frete Grátis. | `frete/CT-FRE-05.png` |
| CT-FRE-06 | Passou | Compra com menor valor possível R$ 49,80, cobra o valor do frete | `frete/CT-FRE-06.png` |
| CT-FRE-07 | Falhou | 2 Mochilas com BEMVINDO10: frete R$ 19,90 e total R$ 199,90 (esperado R$ 180,00). **BUG-01**. | `frete/CT-FRE-07.png` |
| CT-FRE-07b | Passou | Mesma regra validada na API (CT-API-11b) e na interface” | `frete/CT-FRE-07B.png` |
| CT-FRE-08 | Passou | Subtotal abaixo de R$ 200,00 não ganha frete grátis | `frete/CT-FRE-08.png` | 
| CT-FRE-09 | Passou | Desconto de R$ 10,00 sobre R$ 100,00; frete R$ 19,90; total R$ 109,90. | `frete/CT-FRE-09.png` |
| CT-FRE-10 | Passou | Valor faltante para frete grátis é atualizado ao adicionar produtos | `frete/CT-FRE-10.png`|
| CT-FRE-11 | Passou | Valor faltante para frete grátis é atualizado ao remover produtos | `frete/CT-FRE-11.png` |
| CT-FRE-12 | Passou | Sistema sinaliza que o carrinho está vazio, e cupom não aplicado. | `frete/CT-FRE-12.png` |

## Cálculo e quantidade (03-calculo-quantidade.feature)

| Cenário | Resultado | Observação | Evidência |
|---------|-----------|------------|-----------|
| CT-CAL-01 | Passou | Total segue a correta fórmula subtotal - desconto + frete | `calculo/CT-CAL-01.png` |
| CT-CAL-02 | Passou | Precisão decimal - valores com 2 casas, sem erro de ponto flutuante | `calculo/CT-CAL-02.png` |
| CT-CAL-03 | Passou | Subtotal soma preço unitário vezes quantidade de itens distintos  | `calculo/CT-CAL-03.png`|
| CT-QTD-01 | Passou | Quantidade máxima permitida (5) na interface | `calculo/CT-QTD-01.png` |
| CT-QTD-02 | Passou | A interface não permite passar de 5 unidades; a quantidade permanece em 5. | `calculo/CT-QTD-02.png` |
| CT-QTD-03 | Passou | A interface não permite ultrapassar 5 ao adicionar o mesmo produto várias vezes. | `calculo/CT-QTD-03.png`|
| CT-QTD-04 | Passou | Limite é por produto, não por pedido | `calculo/CT-QTD-04.png` |
| CT-QTD-05 | Passou | Valores inválidos no campo de quantidade da interface não são aceitos | `calculo/CT-QTD-05.png` |
| CT-QTD-06 | Passou | Persistência do carrinho ao recarregar a página (mesma aba) | `calculo/CT-QTD-06.png` |

## Validação do cliente (04-validacao-cliente.feature)

| Cenário | Resultado | Observação | Evidência |
|---------|-----------|------------|-----------|
| CT-CLI-01 | Passou | Pedido confirmado com dados validos  | `cliente/CT-CLI-01.png` |
| CT-CLI-02 | Passou | Nome precisa ter nome e sobrenome  | `cliente/CT-CLI-02.png` |
| CT-CLI-03 | Passou | Cliente precisa ter e-mail valido | `cliente/CT-CLI-03.png` |
| CT-CLI-04 | Passou | CEP precisa ser valido (8 dígitos, com ou sem hífen) | `cliente/CT-CLI-04.png` |
| CT-CLI-05 | Passou | Sistema não aceita vários campos inválidos ao mesmo tempo | `cliente/CT-CLI-05.png` |
| CT-CLI-06 | Passou | Dados do formulário e cupom ao confirmar pedido com cupom | `cliente/CT-CLI-06.png` |

## API (05-api.feature)

| Cenário | Resultado | Observação | Evidência |
|---------|-----------|------------|-----------|
| CT-API-01 | Passou | 200 com os 8 produtos. | `api/CT-API-01.png` |
| CT-API-02 | Passou | 200, Camiseta Essencial, preço 59.9. | `api/CT-API-02.png` |
| CT-API-03 | Passou | 404 `PRODUTO_NAO_ENCONTRADO`. Ver AMB-13. | `api/CT-API-03.png` |
| CT-API-04 | Passou | 404 ROTA_NAO_ENCONTRADA |`api/CT-API-04.png` |
| CT-API-05 | Passou | 405 METODO_NAO_PERMITIDO | `api/CT-API-05.png` |
| CT-API-06 | Passou | Exemplo da documentação: total 215.73. | `api/CT-API-06.png` |
| CT-API-07 | Passou | Calcular com cupom inexistente não gera erro | `api/CT-API-07.png` |
| CT-API-08 | Passou | Calcular com cupom expirado não gera erro | `api/CT-API-08.png` |
| CT-API-09 | Passou | Cupom `" BEMVINDO10     "` aplicado e normalizado. | `api/CT-API-09.png` |
| CT-API-10 | Falhou | P005 x2: frete 19.9, `freteGratis` false, total 219.9. **BUG-01**. P004 x4 (199.6) passou. | `api/CT-API-10.png` |
| CT-API-11 | Falhou | P005 x2 com BEMVINDO10: frete 19.9, total 199.9 (esperado 180). **BUG-01**. | `api/CT-API-11.png` |
| CT-API-11b | Passou | P004 x3 + P001 com BEMVINDO10: frete 0 e total 188.64. | `api/CT-API-11b.png` |
| CT-API-12 | Falhou | 6 unidades: 200 no `/calcular` e 201 no `/pedidos`; 100 unidades: 200. **BUG-02**. Automatizado com `test.fail()`. | `api/CT-API-12.png`, `automacao/CT-API-12-bug.png` |
| CT-API-13 | Passou | Coberto também pela automação. | `api/CT-API-13.png` |
| CT-API-14 | Passou | Quantidade inválida 422 | `api/CT-API-14.png` |
| CT-API-15 | Falhou | Linha do item vazio: `PRODUTO_NAO_ENCONTRADO` com "undefined" (**BUG-03**). Demais linhas passaram. | `api/CT-API-15.png` |
| CT-API-16 | Passou | `/calcular` com JSON inválido: 400 `JSON_INVALIDO`. `/pedidos` também retorna 400 JSON_INVALIDO. | `api/CT-API-16.png` |
| CT-API-17 | Passou | Corpo JSON que não é objeto = 400 `JSON_INVALIDO`| `api/CT-API-17.png` |
| CT-API-18 | Passou | Resposta idêntica a primeira | `api/CT-API-18.png`|
| CT-API-19 | Passou | 201, número `VZ-` + 6 dígitos, CEP normalizado. | `api/CT-API-19.png` |
| CT-API-20 | Passou | 200 pedido sem cupom aplicado  | `api/CT-API-20.png` |
| CT-API-21 | Passou | 422 `CUPOM_INVALIDO`. | `api/CT-API-21.png` |
| CT-API-22 | Passou | 422 Pedido com cupom expirado | `api/CT-API-22.png` |
| CT-API-23 | Passou | 422 Dados do cliente inválidos no pedido  | `api/CT-API-23.png` |
| CT-API-24 | Passou | 422 `DADOS_INVALIDOS` com detalhes em `campos`, sem erro 500. | `api/CT-API-24.png` |
| CT-API-25 | Passou | 201 Pedido e cálculo retornam os mesmos valores  | `api/CT-API-25.png`|
| CT-API-26 | Falhou | Cupom enviado como objeto devolve `"[object Object]"` em `cupom.codigo`. **BUG-04**. | `api/CT-API-26.png` |
| CT-API-27 | Passou | Mais de um cupom enviado ao mesmo tempo na API | `api/CT-API-27.png` |
