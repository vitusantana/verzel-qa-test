# Teste técnico QA Júnior - Verzel

Teste técnico de QA da Verzel sobre a entrega **VZS-142** (cupom de desconto e frete grátis, versão 2.3.0) da Verzel Store.

Este repositório reúne cenários em Gherkin, execução manual e exploratória, reports de bugs, evidências e automação com Playwright.

## Onde encontrar cada entrega

| Entrega pedida | Onde está |
|----------------|-----------|
| Cenários de teste (Gherkin) | [`cenarios/`](cenarios/) (5 arquivos `.feature`) |
| Execução dos testes, com o resultado de cada cenário | [`execucao/resultados.md`](execucao/resultados.md) |
| Report de todos os bugs encontrados | [`bugs/`](bugs/) (índice em [`bugs/README.md`](bugs/README.md)) |
| Documento com as evidências da execução | [`evidencias/`](evidencias/) (legendas em [`evidencias/README.md`](evidencias/README.md)) |
| Automação de pelo menos 3 cenários com Playwright | [`automacao/`](automacao/) |
| Ambiguidades da documentação e interpretação adotada | [`ambiguidades.md`](ambiguidades.md) |
| Rastreabilidade (critério de aceite x cenários) | [`matriz-rastreabilidade.md`](matriz-rastreabilidade.md) |

## Estrutura do repositório

```
.
├── README.md
├── ambiguidades.md
├── matriz-rastreabilidade.md
├── cenarios/        # .feature: cupom, frete, cálculo e quantidade, cliente e API
├── execucao/        # resultados.md: resultado de cada cenário
├── bugs/            # BUG-01 a BUG-04 e legenda de severidade
├── evidencias/      # prints por feature (cupom, frete, calculo, cliente, api, automacao)
└── automacao/       # projeto Playwright (TypeScript)
```

## Cenários

Escritos em Gherkin (Dado, Quando, Então), em português, com IDs no formato `CT-XXX-NN` (por exemplo, `CT-FRE-02`) e tags `@CAxx` para o critério de aceite coberto. Cenários com `@BUG-xx` estão ligados a um bug e os com `@automacao` foram automatizados.

| Arquivo | Conteúdo |
|---------|----------|
| `01-cupom.feature` | Aplicação de cupom (CA01 a CA05) |
| `02-frete.feature` | Regra de frete grátis (CA06 a CA09) |
| `03-calculo-quantidade.feature` | Cálculo do total e limite de 5 unidades (CA10 e CA11) |
| `04-validacao-cliente.feature` | Nome, e-mail e CEP (regras pré-existentes) |
| `05-api.feature` | Endpoints e códigos de erro da API |

Os resultados completos estão em [`execucao/resultados.md`](execucao/resultados.md), com o resumo de cenários que passaram, falharam e não se aplicam.

## Bugs encontrados

| ID | Título | Severidade |
|----|--------|------------|
| [BUG-01](bugs/BUG-01.md) | API não concede frete grátis quando o subtotal é exatamente R$ 200,00 | Alta |
| [BUG-02](bugs/BUG-02.md) | API não aplica o limite de 5 unidades por produto (cálculo e pedido) | Alta |
| [BUG-03](bugs/BUG-03.md) | Item vazio retorna `PRODUTO_NAO_ENCONTRADO` com "undefined" na mensagem | Baixa |
| [BUG-04](bugs/BUG-04.md) | Cupom enviado como objeto devolve `"[object Object]"` em `cupom.codigo` | Baixa |

A legenda de severidade está em [`bugs/README.md`](bugs/README.md).

## Automação com Playwright

Três cenários automatizados, mais um de controle:

| Cenário | Tipo | Arquivo |
|---------|------|---------|
| CT-CUP-01: aplicar o cupom BEMVINDO10 | Interface | `tests/cupom.spec.ts` |
| CT-FRE-02: frete grátis com subtotal de R$ 200,00 | Interface | `tests/frete.spec.ts` |
| CT-API-12: limite de 5 unidades por produto | API | `tests/api-quantidade.spec.ts` |
| CT-API-13: quantidade 5 é aceita (controle positivo) | API | `tests/api-quantidade.spec.ts` |

### Como rodar

Pré-requisito: [Node.js](https://nodejs.org) (versão LTS).

```bash
cd automacao
npm install
npx playwright install    # baixa os navegadores, apenas na primeira vez
npx playwright test
```

Opções úteis:

```bash
npx playwright test --headed        # abre o navegador durante a execução
npx playwright test --ui            # modo interativo
npx playwright show-report          # abre o relatório HTML da última execução
```

A URL base da loja está configurada em `automacao/playwright.config.ts`.

### Como interpretar o resultado

Os testes do **CT-FRE-02** e do **CT-API-12** verificam o comportamento que a documentação exige, mas o sistema tem defeito (BUG-01 e BUG-02). Por isso estão marcados com `test.fail()`:

- O Playwright mostra `✗` ao lado desses testes e conta como `passed`. Isso é o esperado: a falha é conhecida.
- Quando o bug for corrigido, o teste passará a falhar e avisará que a linha `test.fail()` pode ser removida (teste de regressão).

Resultado esperado de `npx playwright test`: **4 passed**, com `✗` no CT-FRE-02 e no CT-API-12.

Prints da execução: [`evidencias/automacao/`](evidencias/automacao/).

## Ambiente e premissas

- O ambiente é compartilhado e foi testado sem carga, estresse ou segurança, conforme o escopo do enunciado.
- Comportamentos listados em "Sobre este ambiente" da documentação (carrinho por aba, pedidos não armazenados etc.) não foram tratados como bug.
- Pontos que a documentação não define estão em [`ambiguidades.md`](ambiguidades.md), com a interpretação adotada. Exemplo: o frete zerado aparece como "Grátis" na interface, tratado como formato de exibição equivalente a R$ 0,00.
- Ferramentas: Chrome (interface), Postman (API) e Playwright (automação).

## Uso de IA

Usei o Claude (Anthropic) como apoio para:

- Organização da documentação do repositório;
- Ajuda na revisão dos cenários testados. 
