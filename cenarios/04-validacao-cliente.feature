@VZS-142 @cliente @regressao
Funcionalidade: Validação dos dados do cliente na confirmação do pedido (regras pré-existentes)

  Contexto:
    Dado que o carrinho tem 1 unidade de "Mochila Urbana 20L"

  @CT-CLI-01
  Cenário: Confirmar pedido com dados válidos
    Quando preencho nome "Maria Silva", e-mail "maria@exemplo.com" e CEP "01310-100"
    E confirmo o pedido
    Então o pedido é confirmado com número no formato "VZ-000000"
    E o pagamento é informado como na entrega (sem etapa de pagamento online)

  @CT-CLI-02
  Esquema do Cenário: Nome precisa ter nome e sobrenome
    Quando preencho o nome "<nome>" com e-mail e CEP válidos e confirmo
    Então o resultado esperado é "<resultado>"

    Exemplos:
      | nome            | resultado |
      | Maria           | erro      |
      | (vazio)         | erro      |
      | "   "          | erro      |
      | Maria Silva     | sucesso   |
      | Ana Maria Souza | sucesso   |
      | " Maria  Silva "| sucesso   |

  @CT-CLI-03
  Esquema do Cenário: Formato do e-mail
    Quando preencho o e-mail "<email>" com nome e CEP válidos e confirmo
    Então o resultado esperado é "<resultado>"

    Exemplos:
      | email              | resultado |
      | maria@exemplo.com  | sucesso   |
      | maria.s+t@ex.com.br| sucesso   |
      | maria              | erro      |
      | maria@             | erro      |
      | @exemplo.com       | erro      |
      | maria@exemplo      | erro      |
      | maria silva@ex.com | erro      |

  @CT-CLI-04
  Esquema do Cenário: Formato do CEP (8 dígitos, com ou sem hífen)
    Quando preencho o CEP "<cep>" com nome e e-mail válidos e confirmo
    Então o resultado esperado é "<resultado>"

    Exemplos:
      | cep       | resultado |
      | 01310-100 | sucesso   |
      | 01310100  | sucesso   |
      | 0131010   | erro      |
      | 013101000 | erro      |
      | 01310-10  | erro      |
      | abcde-fgh | erro      |
      | (vazio)   | erro      |

  @CT-CLI-05 @exploratorio
  Cenário: Vários campos inválidos ao mesmo tempo
    Quando deixo nome, e-mail e CEP inválidos e confirmo
    Então todos os campos inválidos são sinalizados, com mensagem clara em cada um

  @CT-CLI-06 @exploratorio
  Cenário: Dados do formulário e cupom ao confirmar pedido com cupom
    Dado que o cupom "BEMVINDO10" está aplicado
    Quando confirmo o pedido com dados válidos
    Então o resumo do pedido mostra os mesmos valores do carrinho (subtotal, desconto, frete e total)
