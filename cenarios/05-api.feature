@VZS-142 @api
Funcionalidade: API da Verzel Store (/api)
  # Content-Type: application/json | valores monetários em reais (ex.: 59.9)

  # ---------- GET /api/produtos ----------
  @CT-API-01
  Cenário: Listar produtos
    Quando envio GET para "/api/produtos"
    Então o status é 200
    E a resposta contém os 8 produtos P001 a P008
    E cada produto tem id, nome, descricao, categoria e preco

  @CT-API-02
  Cenário: Consultar produto existente
    Quando envio GET para "/api/produtos/P001"
    Então o status é 200
    E o produto é "Camiseta Essencial" com preco 59.9

  @CT-API-03
  Cenário: Consultar produto inexistente
    Quando envio GET para "/api/produtos/P999"
    Então o status é 404
    E o erro.codigo é "PRODUTO_NAO_ENCONTRADO"

  @CT-API-04
  Cenário: Rota inexistente
    Quando envio GET para "/api/xyz"
    Então o status é 404
    E o erro.codigo é "ROTA_NAO_ENCONTRADA"

  @CT-API-05
  Esquema do Cenário: Método HTTP não permitido
    Quando envio <metodo> para "<rota>"
    Então o status é 405
    E o erro.codigo é "METODO_NAO_PERMITIDO"

    Exemplos:
      | metodo | rota                  |
      | POST   | /api/produtos         |
      | DELETE | /api/produtos/P001    |
      | GET    | /api/carrinho/calcular|
      | GET    | /api/pedidos          |
      | PUT    | /api/pedidos          |

  # ---------- POST /api/carrinho/calcular ----------
  @CT-API-06 @CA01 @CA06 @CA09
  Cenário: Calcular carrinho com cupom válido (exemplo da documentação)
    Quando envio POST para "/api/carrinho/calcular" com itens P002 x1 e P004 x2 e cupom "BEMVINDO10"
    Então o status é 200
    E subtotal é 239.7, desconto é 23.97, frete é 0, freteGratis é true, valorFaltanteFreteGratis é 0 e total é 215.73
    E cupom.aplicado é true

  @CT-API-07 @CA03
  Cenário: Calcular com cupom inexistente não gera erro
    Quando envio POST para "/api/carrinho/calcular" com item P005 x1 e cupom "NAOEXISTE"
    Então o status é 200
    E desconto é 0 e cupom.aplicado é false
    E cupom.mensagem é "Cupom inválido."

  @CT-API-08 @CA04
  Cenário: Calcular com cupom expirado não gera erro
    Quando envio POST para "/api/carrinho/calcular" com item P005 x1 e cupom "VERAO2026"
    Então o status é 200
    E desconto é 0 e cupom.aplicado é false
    E cupom.mensagem é "Cupom expirado."

  @CT-API-09 @CA02
  Esquema do Cenário: Cupom na API ignora caixa e espaços nas pontas
    Quando envio POST para "/api/carrinho/calcular" com item P005 x1 e cupom "<cupom>"
    Então desconto é 10 e cupom.aplicado é true

    Exemplos:
      | cupom        |
      | bemvindo10   |
      | " BEMVINDO10 " |
      | " BemVindo10" |

  @CT-API-10 @CA06 @CA07 @CA08 @BUG-01
  Esquema do Cenário: Fronteira do frete grátis via API
    Quando envio POST para "/api/carrinho/calcular" com item <produto> x<qtd>
    Então subtotal é <subtotal>, frete é <frete>, freteGratis é <gratis> e valorFaltanteFreteGratis é <faltante>

    Exemplos:
      | produto | qtd | subtotal | frete | gratis | faltante |
      | P005    | 1   | 100      | 19.9  | false  | 100      |
      | P004    | 4   | 199.6    | 19.9  | false  | 0.4      |
      | P005    | 2   | 200      | 0     | true   | 0        |
      | P008    | 4   | 200      | 0     | true   | 0        |
      | P007    | 1   | 229.9    | 0     | true   | 0        |

  @CT-API-11 @CA08 @BUG-01
  Cenário: API - frete grátis calculado antes do desconto
    Quando envio POST para "/api/carrinho/calcular" com item P005 x2 e cupom "BEMVINDO10"
    Então subtotal é 200, desconto é 20, frete é 0 e total é 180

  @CT-API-11b @CA08 @CA09
  Cenário: API - frete grátis considera o subtotal antes do desconto (fora do limite exato)
    # Dados escolhidos para não coincidir com o limite exato de R$ 200,00 (ver BUG-01)
    Quando envio POST para "/api/carrinho/calcular" com itens P004 x3 e P001 x1 e cupom "BEMVINDO10"
    Então subtotal é 209.6, desconto é 20.96, frete é 0 e total é 188.64

  @CT-API-12 @CA10 @automacao @BUG-02
  Esquema do Cenário: Limite de quantidade por produto (API)
    Quando envio POST para "<rota>" com item P001 x<qtd>
    Então o status é <status>
    E o erro.codigo é "<codigo>"

    Exemplos:
      | rota                     | qtd | status | codigo                     |
      | /api/carrinho/calcular   | 6   | 422    | QUANTIDADE_MAXIMA_EXCEDIDA |
      | /api/carrinho/calcular   | 100 | 422    | QUANTIDADE_MAXIMA_EXCEDIDA |
      | /api/pedidos             | 6   | 422    | QUANTIDADE_MAXIMA_EXCEDIDA |

  @CT-API-13 @CA10
  Cenário: Quantidade 5 (máximo) é aceita na API
    Quando envio POST para "/api/carrinho/calcular" com item P001 x5
    Então o status é 200 e subtotal é 299.5

  @CT-API-14
  Esquema do Cenário: Quantidade inválida
    Quando envio POST para "/api/carrinho/calcular" com item P001 e quantidade <qtd>
    Então o status é 422
    E o erro.codigo é "QUANTIDADE_INVALIDA"
    E o erro.campo é "itens[0].quantidade"

    Exemplos:
      | qtd   |
      | 0     |
      | -1    |
      | 1.5   |
      | "2"   |
      | null  |
      | "abc" |

  @CT-API-15 @BUG-03
  Esquema do Cenário: Validação da lista de itens
    Quando envio POST para "/api/carrinho/calcular" com o corpo "<corpo>"
    Então o status é 422
    E o erro.codigo é "<codigo>"

    Exemplos:
      | corpo                                              | codigo                |
      | {}                                                 | ITENS_OBRIGATORIOS    |
      | {"itens": []}                                      | ITENS_OBRIGATORIOS    |
      | {"itens": "P001"}                                  | ITENS_OBRIGATORIOS ou ITEM_INVALIDO (registrar) |
      | {"itens": ["P001"]}                                | ITEM_INVALIDO         |
      | {"itens": [{}]}                                    | ITEM_INVALIDO (obtido PRODUTO_NAO_ENCONTRADO com "undefined": BUG-03) |
      | {"itens": [{"produtoId":"P001"}]}                  | ITEM_INVALIDO ou QUANTIDADE_INVALIDA (registrar) |
      | {"itens": [{"produtoId":"P999","quantidade":1}]}   | PRODUTO_NAO_ENCONTRADO |
      | {"itens": [{"produtoId":"P001","quantidade":1},{"produtoId":"P001","quantidade":2}]} | ITEM_DUPLICADO |

  @CT-API-16
  Esquema do Cenário: JSON inválido
    Quando envio POST para "<rota>" com corpo "{itens: [" (JSON malformado)
    Então o status é 400
    E o erro.codigo é "JSON_INVALIDO"

    Exemplos:
      | rota                   |
      | /api/carrinho/calcular |
      | /api/pedidos           |

  @CT-API-17 @exploratorio
  Cenário: Corpo JSON que não é objeto (array, número, null)
    Quando envio POST para "/api/carrinho/calcular" com corpo "[]"
    Então o status é 400
    E o erro.codigo é "JSON_INVALIDO"

  @CT-API-18 @exploratorio
  Cenário: Cálculo não grava estado (idempotência)
    Quando envio duas vezes a mesma requisição para "/api/carrinho/calcular"
    Então as duas respostas são idênticas

  # ---------- POST /api/pedidos ----------
  @CT-API-19 @CA09
  Cenário: Criar pedido com cupom (exemplo da documentação)
    Quando envio POST para "/api/pedidos" com cliente "Maria Silva", "maria@exemplo.com", "01310-100", item P005 x1 e cupom "BEMVINDO10"
    Então o status é 201
    E numero segue o padrão "VZ-" seguido de 6 dígitos
    E cliente.cep é "01310100"
    E subtotal é 100, desconto é 10, frete é 19.9, freteGratis é false, valorFaltanteFreteGratis é 100 e total é 109.9
    E criadoEm é uma data/hora ISO 8601 válida

  @CT-API-20
  Cenário: Pedido sem cupom
    Quando envio POST para "/api/pedidos" com dados válidos e sem o campo cupom
    Então o status é 201 e desconto é 0

  @CT-API-21 @CA03
  Cenário: Pedido com cupom inexistente
    Quando envio POST para "/api/pedidos" com dados válidos e cupom "NAOEXISTE"
    Então o status é 422
    E o erro.codigo é "CUPOM_INVALIDO"

  @CT-API-22 @CA04
  Cenário: Pedido com cupom expirado
    Quando envio POST para "/api/pedidos" com dados válidos e cupom "VERAO2026"
    Então o status é 422
    E o erro.codigo é "CUPOM_EXPIRADO"

  @CT-API-23
  Esquema do Cenário: Dados do cliente inválidos no pedido
    Quando envio POST para "/api/pedidos" com cliente nome "<nome>", email "<email>" e cep "<cep>"
    Então o status é 422
    E o erro.codigo é "DADOS_INVALIDOS"
    E o erro traz os detalhes dos campos inválidos em "campos"

    Exemplos:
      | nome        | email           | cep       |
      | Maria       | maria@ex.com    | 01310-100 |
      | Maria Silva | maria           | 01310-100 |
      | Maria Silva | maria@ex.com    | 123       |
      | Maria       | maria           | 123       |

  @CT-API-24 @exploratorio
  Cenário: Pedido sem o objeto cliente
    Quando envio POST para "/api/pedidos" com itens válidos e sem o campo cliente
    Então o status é 422 com erro DADOS_INVALIDOS, sem erro 500

  @CT-API-25 @exploratorio
  Cenário: Pedido e cálculo retornam os mesmos valores para a mesma entrada
    Quando calculo e depois confirmo o mesmo carrinho com o mesmo cupom
    Então subtotal, desconto, frete e total são iguais nas duas respostas

  @CT-API-26 @exploratorio
  Cenário: Cupom com tipo inválido na API
    Quando envio POST para "/api/carrinho/calcular" com cupom 123 (número), null ou "" (vazio)
    Então a API responde de forma consistente, sem erro 500
    # Observado: cupom enviado como objeto devolve cupom.codigo "[object Object]" (BUG-04)

  @CT-API-27 @exploratorio
  Cenário: Mais de um cupom enviado ao mesmo tempo na API
    Quando envio POST para "/api/carrinho/calcular" com cupom "BEMVINDO10,VERAO2026"
    E depois com cupom ["BEMVINDO10", "VERAO2026"]
    Então nenhum desconto de 10% ou 25% é aplicado indevidamente
    E a API responde sem erro 500
