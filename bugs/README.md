# Bugs encontrados

Entrega avaliada: **VZS-142** (cupom de desconto e frete grátis), versão 2.3.0.
Ambiente: Verzel Store (https://verzel-store.qa-test-verzel-store.workers.dev), Chrome e Postman, 08 e 09/10/2026.

| ID | Título | Severidade | Prioridade | Onde |
|----|--------|------------|------------|------|
| [BUG-01](BUG-01.md) | API não concede frete grátis quando o subtotal é exatamente R$ 200,00 | Alta | Alta | API e interface |
| [BUG-02](BUG-02.md) | API não aplica o limite de 5 unidades por produto (cálculo e pedido) | Alta | Alta | API |
| [BUG-03](BUG-03.md) | Item vazio retorna `PRODUTO_NAO_ENCONTRADO` com "undefined" na mensagem | Baixa | Baixa | API |
| [BUG-04](BUG-04.md) | Cupom enviado como objeto devolve `"[object Object]"` em `cupom.codigo` | Baixa | Baixa | API |

## Legenda de severidade

| Nível | Significado |
|-------|-------------|
| Crítica | Impede o uso principal da loja ou causa perda grave (ex.: não é possível comprar). |
| Alta | Regra de negócio ou valor cobrado errado, sem contorno razoável. |
| Média | Funcionalidade com comportamento incorreto, mas com contorno ou impacto limitado. |
| Baixa | Problema de mensagem, formato ou validação, sem impacto financeiro. |

A **prioridade** indica a ordem sugerida de correção, considerando impacto no cliente e esforço provável.

## Bugs ligados à automação

- BUG-01: `automacao/tests/frete.spec.ts` (CT-FRE-02), marcado com `test.fail()`.
- BUG-02: `automacao/tests/api-quantidade.spec.ts` (CT-API-12), marcado com `test.fail()`.
