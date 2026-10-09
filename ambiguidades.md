# Ambiguidades da documentação e interpretação adotada

| ID | Ponto ambíguo | Interpretação adotada | Cenários |
|----|---------------|-----------------------|----------|
| AMB-01 | CA10 não diz o comportamento da **interface** ao passar de 5 (bloqueia o botão? mostra mensagem? corta para 5?) | Esperado: a UI não permite passar de 5 e a quantidade fica em 5. Qualquer comportamento que permita 6+ no pedido é bug. | CT-QTD-02, 03 |
| AMB-02 | CA10 diz "por pedido", mas a regra fala de "cada produto" | Limite é **por produto** (5 unidades de cada), não 5 no carrinho todo. | CT-QTD-04 |
| AMB-03 | CA05: o que acontece ao tentar aplicar um 2º cupom com outro ativo (mensagem, bloqueio, substituição)? | **Observado na execução:** a interface oculta o campo de cupom depois de aplicar um cupom e só o exibe novamente após remover o cupom atual. Isso impede um segundo cupom e a reaplicação do mesmo, cumprindo o CA05 por design. | CT-CUP-09, 10 |
| AMB-04 | CA02: espaços **no meio** do código | Só pontas são ignoradas, então "BEMVINDO 10" é inválido. | CT-CUP-05 |
| AMB-05 | Cupom vazio / só espaços: não há mensagem definida | Esperado: nenhum desconto e sem erro inesperado; mensagem é opcional. | CT-CUP-12 |
| AMB-06 | CA07 "informa quanto falta" a partir de R$ 200 não diz o que exibir quando já é grátis | Esperado: não exibir valor faltante (ou exibir R$ 0,00). | CT-FRE-02 |
| AMB-07 | Carrinho vazio: frete e total não definidos | Esperado: frete R$ 0,00 e total R$ 0,00. Cobrar R$ 19,90 sem itens seria incoerente. | CT-FRE-12 |
| AMB-08 | CA11: com os preços fixos e 10%, o arredondamento nunca produz 3ª casa; só dá para testar erro de ponto flutuante (ex.: 59.9 x 3) | Verificar que a API/UI devolvem sempre 2 casas, sem resíduos tipo 179.70000000000002. | CT-CAL-02 |
| AMB-09 | Erros de item (`ITEM_INVALIDO` x `QUANTIDADE_INVALIDA`) quando falta `quantidade`, ou `itens` não é array | Registrar o código recebido; ambos são aceitáveis, o que não é aceitável é erro 500. | CT-API-15 |
| AMB-10 | Os códigos de erro valem também para `/carrinho/calcular`? A tabela não separa | Assumido que validações de itens valem para `/calcular` e `/pedidos`. | CT-API-12, 14, 15 |
| AMB-11 | "Nome e sobrenome": espaços duplicados e nomes com acentos/hífen | Aceitar duas palavras ou mais após trim; "Maria  Silva" é válido. | CT-CLI-02 |
| AMB-12 | Mensagem do cupom na UI: CA03/CA04 citam "Cupom inválido." / "Cupom expirado."; a API também usa `cupom.mensagem` | Mesma mensagem na UI e na API. | CT-CUP-06, 07, CT-API-07, 08 |
| AMB-13 | A documentação diz que "todo erro segue o mesmo formato" (com `campo`), mas o 404 de produto inexistente (`GET /api/produtos/P999`) vem sem o campo `campo`. | `campo` só é esperado quando o erro está ligado a um campo da requisição; no 404 de rota/recurso a ausência é aceita. | CT-API-03 |
| AMB-14 | Quando a requisição não envia cupom, a API devolve `"cupom": null`. A documentação só exemplifica a resposta com cupom. | Aceito como comportamento válido para "sem cupom". | CT-API-10, 13, 20 |
| AMB-15 | Frete de R$ 0,00: a documentação fala em "R$ 0,00", mas a interface exibe a palavra "Grátis". | Formato de exibição equivalente, sem ser considerado bug. Valores numéricos na API continuam `frete: 0`. | CT-CUP-01, CT-FRE-02, 03, 05, 07, 11 |
