# BUG-03: Item vazio retorna `PRODUTO_NAO_ENCONTRADO` com "undefined" na mensagem

- **Severidade:** Baixa
- **Prioridade:** Baixa
- **Critério violado:** tabela de códigos de erro (`ITEM_INVALIDO`: "um item não é um objeto com `produtoId` e `quantidade`")
- **Cenário:** CT-API-15
- **Ambiente:** Verzel Store v2.3.0, Postman, 08 e 09/10/2026

**Justificativa:** o pedido é rejeitado corretamente com 422, então nenhum dado inválido passa. O problema é o código de erro e uma mensagem que expõe um valor interno.

## Passos para reproduzir
`POST /api/carrinho/calcular` com:
```json
{ "itens": [ {} ] }
```

## Resultado esperado
`422` com `erro.codigo` igual a `ITEM_INVALIDO`.

## Resultado obtido
`422` com:
```json
{
  "erro": {
    "codigo": "PRODUTO_NAO_ENCONTRADO",
    "mensagem": "Produto undefined não encontrado.",
    "campo": "itens[0].produtoId"
  }
}
```

![CT-API-15](../evidencias/api/CT-API-15.png)

## Observação
A documentação admite outra leitura (produtoId ausente tratado como produto inexistente). Mesmo assim, a mensagem com "undefined" é um problema em qualquer interpretação. Sem erro 500.
