# BUG-04: Cupom enviado como objeto devolve `"[object Object]"` em `cupom.codigo`

- **Severidade:** Baixa
- **Prioridade:** Baixa
- **Cenário:** CT-API-26 (exploratório)
- **Ambiente:** Verzel Store v2.3.0, Postman, 08 e 09/10/2026

**Justificativa:** o cupom é rejeitado e nenhum desconto indevido é aplicado. O problema é a falta de validação do tipo do campo e o código sem sentido devolvido na resposta.

## Passos para reproduzir
`POST /api/carrinho/calcular` com o campo `cupom` como objeto (no teste, o corpo de resposta da documentação foi colado por engano no Body):
```json
{
  "itens": [ { "produtoId": "P002", "quantidade": 1 } ],
  "cupom": { "codigo": "BEMVINDO10" }
}
```

## Resultado esperado
Erro de validação do tipo do campo, ou ao menos `cupom.codigo` vazio. A documentação não define esse caso; a expectativa é uma resposta coerente.

## Resultado obtido
`200 OK`, sem desconto, com:
```json
"cupom": { "codigo": "[object Object]", "aplicado": false, "mensagem": "Cupom inválido." }
```
O objeto foi convertido em texto sem validação.

![CT-API-26](../evidencias/api/CT-API-26.png)

## Observação
Os campos extras do corpo (`nome`, `precoUnitario`, `subtotal`) foram ignorados, e o subtotal veio do preço oficial do produto. Isso é um comportamento correto (o cliente não manipula preço pelo corpo).
