# Evidências da execução

Prints da execução manual e exploratória da entrega **VZS-142**, organizados por feature. Cada arquivo tem o ID do cenário no nome (por exemplo, `frete/CT-FRE-02.png`). O resultado de cada cenário está em [`../execucao/resultados.md`](../execucao/resultados.md).

Ambiente: Verzel Store (interface, no Chrome), Postman (API) e Playwright (automação), em 08 e 09/10/2026.

Cenários sem print próprio têm o resultado registrado em texto em `execucao/resultados.md`. O CT-CUP-11 foi fundido ao CT-CUP-09 e usa a mesma evidência.

## Índice

- [Cupom](#cupom) (`cupom/`)
- [Frete](#frete) (`frete/`)
- [Cálculo e quantidade](#calculo) (`calculo/`)
- [Validação do cliente](#cliente) (`cliente/`)
- [API](#api) (`api/`)
- [Automação](#automação) (`automacao/`)

## Cupom

### CT-CUP-01 - Passou

Cupom BEMVINDO10 aplicado: subtotal R$ 239,70, desconto R$ 23,97, frete Grátis e total R$ 215,73.

![CT-CUP-01](cupom/CT-CUP-01.png)

### CT-CUP-02 - Passou

Desconto de 10% sobre o subtotal (Camiseta Essencial: desconto R$ 5,99 e total R$ 73,81).

![CT-CUP-02](cupom/CT-CUP-02.png)

### CT-CUP-03 - Passou

O código do cupom não diferencia maiúsculas de minúsculas.

![CT-CUP-03](cupom/CT-CUP-03.png)

### CT-CUP-04 - Passou

Espaços no início e no fim do código são ignorados e o cupom é aplicado.

![CT-CUP-04](cupom/CT-CUP-04.png)

### CT-CUP-05 - Passou

Código com espaço no meio é rejeitado.

![CT-CUP-05](cupom/CT-CUP-05.png)

### CT-CUP-06 - Passou

Cupom inexistente é rejeitado e nenhum desconto é aplicado.

![CT-CUP-06](cupom/CT-CUP-06.png)

### CT-CUP-07 - Passou

Cupom expirado (VERAO2026) é rejeitado e nenhum desconto é aplicado.

![CT-CUP-07](cupom/CT-CUP-07.png)

### CT-CUP-08 - Passou

Cupom expirado digitado em minúsculas e com espaços é rejeitado como expirado.

![CT-CUP-08](cupom/CT-CUP-08.png)

### CT-CUP-09 - Passou

Com um cupom aplicado, o campo de cupom some e não é possível reaplicar o mesmo (cobre também o antigo CT-CUP-11).

![CT-CUP-09](cupom/CT-CUP-09.png)

### CT-CUP-10 - Passou

Remoção do cupom atual: o total é recalculado sem desconto.

![CT-CUP-10](cupom/CT-CUP-10.png)

### CT-CUP-12 - Passou

Aplicar sem informar código: nenhum desconto e sem erro inesperado.

![CT-CUP-12](cupom/CT-CUP-12.png)

### CT-CUP-13 - Passou

Desconto recalculado ao alterar a quantidade com cupom aplicado.

![CT-CUP-13](cupom/CT-CUP-13.png)

### CT-CUP-14 - Passou

Desconto recalculado ao remover itens; com o carrinho vazio não aparecem valores negativos.

![CT-CUP-14](cupom/CT-CUP-14.png)

## Frete

### CT-FRE-01 - Passou

Frete fixo de R$ 19,90 abaixo de R$ 200,00, com o valor faltante informado.

![CT-FRE-01](frete/CT-FRE-01.png)

### CT-FRE-02 - Falhou ([BUG-01](../bugs/BUG-01.md))

2 Mochilas (subtotal R$ 200,00): frete cobrado em R$ 19,90 em vez de Grátis.

![CT-FRE-02](frete/CT-FRE-02.png)

### CT-FRE-03 - Falhou ([BUG-01](../bugs/BUG-01.md))

4 Garrafas Térmicas (subtotal R$ 200,00): frete cobrado em R$ 19,90.

![CT-FRE-03](frete/CT-FRE-03.png)

### CT-FRE-04 - Passou

Subtotal de R$ 199,60: frete cobrado e faltante de R$ 0,40.

![CT-FRE-04](frete/CT-FRE-04.png)

### CT-FRE-05 - Passou

Subtotal acima de R$ 200,00: frete Grátis.

![CT-FRE-05](frete/CT-FRE-05.png)

### CT-FRE-07b - Passou

3 Bonés e 1 Camiseta com BEMVINDO10 (subtotal R$ 209,60): frete Grátis e total R$ 188,64.

![CT-FRE-07b](frete/CT-FRE-07B.png)

### CT-FRE-08 - Passou

Subtotal abaixo de R$ 200,00 não ganha frete grátis por causa do cupom.

![CT-FRE-08](frete/CT-FRE-08.png)

### CT-FRE-09 - Passou

O desconto incide só sobre os produtos, não sobre o frete.

![CT-FRE-09](frete/CT-FRE-09.png)

### CT-FRE-10 - Passou

Valor faltante para o frete grátis atualizado ao adicionar produtos.

![CT-FRE-10](frete/CT-FRE-10.png)

### CT-FRE-11 - Passou

Ao reduzir a quantidade, o frete e o valor faltante são atualizados.

![CT-FRE-11](frete/CT-FRE-11.png)

### CT-FRE-12 - Passou

Carrinho vazio: o sistema sinaliza que está vazio e não há cupom aplicado.

![CT-FRE-12](frete/CT-FRE-12.png)

## Cálculo e quantidade

### CT-CAL-01 - Passou

Total segue a fórmula subtotal - desconto + frete.

![CT-CAL-01](calculo/CT-CAL-01.png)

### CT-CAL-02 - Passou

Precisão decimal: valores com 2 casas, sem erro de ponto flutuante.

![CT-CAL-02](calculo/CT-CAL-02.png)

### CT-CAL-03 - Passou

Subtotal soma preço unitário vezes quantidade de itens distintos.

![CT-CAL-03](calculo/CT-CAL-03.png)

### CT-QTD-01 - Passou

Quantidade máxima permitida (5) aceita na interface.

![CT-QTD-01](calculo/CT-QTD-01.png)

### CT-QTD-02 - Passou

A interface não permite passar de 5 unidades; a quantidade permanece em 5.

![CT-QTD-02](calculo/CT-QTD-02.png)

### CT-QTD-03 - Passou

A interface não permite ultrapassar 5 ao adicionar o mesmo produto várias vezes.

![CT-QTD-03](calculo/CT-QTD-03.png)

### CT-QTD-04 - Passou

O limite é por produto, não por pedido.

![CT-QTD-04](calculo/CT-QTD-04.png)

### CT-QTD-05 - Passou

Valores inválidos no campo de quantidade não são aceitos.

![CT-QTD-05](calculo/CT-QTD-05.png)

### CT-QTD-06 - Passou

O carrinho persiste ao recarregar a página (mesma aba).

![CT-QTD-06](calculo/CT-QTD-06.png)

## Validação do cliente

### CT-CLI-01 - Passou

Pedido confirmado com dados válidos.

![CT-CLI-01](cliente/CT-CLI-01.png)

### CT-CLI-02 - Passou

O nome precisa ter nome e sobrenome.

![CT-CLI-02](cliente/CT-CLI-02.png)

### CT-CLI-03 - Passou

O e-mail precisa ter um formato válido.

![CT-CLI-03](cliente/CT-CLI-03.png)

### CT-CLI-04 - Passou

O CEP precisa ter 8 dígitos, com ou sem hífen.

![CT-CLI-04](cliente/CT-CLI-04.png)

### CT-CLI-05 - Passou

Vários campos inválidos ao mesmo tempo são sinalizados.

![CT-CLI-05](cliente/CT-CLI-05.png)

### CT-CLI-06 - Passou

Pedido confirmado com cupom: valores do resumo iguais aos do carrinho.

![CT-CLI-06](cliente/CT-CLI-06.png)

## API

### CT-API-01 - Passou

GET /api/produtos: 200 com os 8 produtos.

![CT-API-01](api/CT-API-01.png)

### CT-API-02 - Passou

GET /api/produtos/P001: 200, Camiseta Essencial, preço 59.9.

![CT-API-02](api/CT-API-02.png)

### CT-API-03 - Passou

GET /api/produtos/P999: 404 com PRODUTO_NAO_ENCONTRADO.

![CT-API-03](api/CT-API-03.png)

### CT-API-04 - Passou

Rota inexistente: 404 com ROTA_NAO_ENCONTRADA.

![CT-API-04](api/CT-API-04.png)

### CT-API-05 - Passou

Método HTTP não permitido: erro METODO_NAO_PERMITIDO.

![CT-API-05](api/CT-API-05.png)

### CT-API-06 - Passou

Exemplo da documentação no /calcular: total 215.73.

![CT-API-06](api/CT-API-06.png)

### CT-API-07 - Passou

Cupom inexistente no /calcular: 200, sem desconto e mensagem de cupom inválido.

![CT-API-07](api/CT-API-07.png)

### CT-API-08 - Passou

Cupom expirado no /calcular: 200, sem desconto e mensagem de cupom expirado.

![CT-API-08](api/CT-API-08.png)

### CT-API-09 - Passou

Cupom com espaços nas pontas aplicado e normalizado.

![CT-API-09](api/CT-API-09.png)

### CT-API-10 - Falhou ([BUG-01](../bugs/BUG-01.md))

P005 x2: frete 19.9, freteGratis false e total 219.9 (esperado: frete 0).

![CT-API-10](api/CT-API-10.png)

### CT-API-11 - Falhou ([BUG-01](../bugs/BUG-01.md))

P005 x2 com BEMVINDO10: frete 19.9 e total 199.9 (esperado: frete 0 e total 180).

![CT-API-11](api/CT-API-11.png)

### CT-API-11b - Passou

P004 x3 e P001 com BEMVINDO10: frete 0 e total 188.64.

![CT-API-11b](api/CT-API-11b.png)

### CT-API-12 - Falhou ([BUG-02](../bugs/BUG-02.md))

6 unidades aceitas no /calcular (200) e no /pedidos (201); 100 unidades aceitas no /calcular (esperado: 422).

![CT-API-12](api/CT-API-12.png)

### CT-API-13 - Passou

Quantidade 5 (máximo) aceita na API.

![CT-API-13](api/CT-API-13.png)

### CT-API-14 - Passou

Quantidade inválida retorna 422.

![CT-API-14](api/CT-API-14.png)

### CT-API-15 - Falhou ([BUG-03](../bugs/BUG-03.md))

Item vazio: PRODUTO_NAO_ENCONTRADO com "undefined" na mensagem (esperado: ITEM_INVALIDO).

![CT-API-15](api/CT-API-15.png)

### CT-API-16 - Passou

JSON inválido: 400 com JSON_INVALIDO.

![CT-API-16](api/CT-API-16.png)

### CT-API-17 - Passou

Corpo JSON que não é objeto: 400 com JSON_INVALIDO.

![CT-API-17](api/CT-API-17.png)

### CT-API-18 - Passou

O cálculo não grava estado: a segunda resposta é idêntica à primeira.

![CT-API-18](api/CT-API-18.png)

### CT-API-19 - Passou

POST /api/pedidos: 201, número VZ- seguido de 6 dígitos e CEP normalizado.

![CT-API-19](api/CT-API-19.png)

### CT-API-20 - Passou

Pedido sem cupom aceito, sem desconto aplicado.

![CT-API-20](api/CT-API-20.png)

### CT-API-21 - Passou

Pedido com cupom inexistente: 422 com CUPOM_INVALIDO.

![CT-API-21](api/CT-API-21.png)

### CT-API-22 - Passou

Pedido com cupom expirado: 422 com CUPOM_EXPIRADO.

![CT-API-22](api/CT-API-22.png)

### CT-API-23 - Passou

Dados do cliente inválidos no pedido: 422 com DADOS_INVALIDOS.

![CT-API-23](api/CT-API-23.png)

### CT-API-24 - Passou

422 com DADOS_INVALIDOS e detalhes em campos, sem erro 500.

![CT-API-24](api/CT-API-24.png)

### CT-API-25 - Passou

Pedido e cálculo retornam os mesmos valores para a mesma entrada.

![CT-API-25](api/CT-API-25.png)

### CT-API-26 - Falhou ([BUG-04](../bugs/BUG-04.md))

Cupom enviado como objeto devolve "[object Object]" em cupom.codigo.

![CT-API-26](api/CT-API-26.png)

### CT-API-27 - Passou

Mais de um cupom enviado ao mesmo tempo na API.

![CT-API-27](api/CT-API-27.png)

## Automação

Prints da execução dos testes Playwright (código em [`../automacao/`](../automacao/)). Nos testes com falha conhecida, o print mostra o teste sem `test.fail()` para exibir o erro; no repositório a anotação está ativa.

### CT-FRE-02 - falha reproduzida pela automação ([BUG-01](../bugs/BUG-01.md))

O teste espera frete grátis com subtotal de R$ 200,00 e recebe R$ 19,90.

![CT-FRE-02 automação](automacao/CT-FRE-02-bug.png)

### CT-API-12 - falha reproduzida pela automação ([BUG-02](../bugs/BUG-02.md))

O teste espera `422` para 6 unidades e recebe `200`.

![CT-API-12 automação](automacao/CT-API-12-bug.png)
