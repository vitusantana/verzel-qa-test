@VZS-142 @cupom
Funcionalidade: Aplicação de cupom de desconto no carrinho
  Como cliente da Verzel Store
  Quero aplicar um cupom de desconto
  Para pagar menos nas minhas compras

  Contexto:
    Dado que o carrinho está vazio
    # Cupons: BEMVINDO10 = 10% (válido) | VERAO2026 = 15% (expirado em 31/03/2026)
    # Na interface, frete de R$ 0,00 é exibido como "Grátis" (AMB-15)

  @CT-CUP-01 @CA01 @CA09 @automacao
  Cenário: Aplicar o cupom válido BEMVINDO10 na interface
    Dado que adicionei 1 unidade de "Calça Jeans Slim" e 2 unidades de "Boné Aba Curva" ao carrinho
    Quando informo o cupom "BEMVINDO10" e clico em aplicar
    Então o subtotal exibido é "R$ 239,70"
    E o desconto exibido é "R$ 23,97"
    E o frete exibido é "Grátis"
    E o total exibido é "R$ 215,73"

  @CT-CUP-02 @CA01
  Esquema do Cenário: Desconto de 10% sobre o subtotal dos produtos
    Dado que adicionei <quantidade> unidade(s) de "<produto>" ao carrinho
    Quando aplico o cupom "BEMVINDO10"
    Então o desconto é "<desconto>"
    E o total é "<total>"

    Exemplos:
      | produto             | quantidade | desconto | total     |
      | Camiseta Essencial  | 1          | 5,99     | 73,81     |
      | Calça Jeans Slim    | 1          | 13,99    | 145,81    |
      | Tênis Casual Urbano | 1          | 18,99    | 190,81    |
      | Mochila Urbana 20L  | 1          | 10,00    | 109,90    |
      | Jaqueta Corta-Vento | 1          | 22,99    | 206,91    |

  @CT-CUP-03 @CA02
  Esquema do Cenário: Código do cupom não diferencia maiúsculas de minúsculas
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    Quando informo o cupom "<codigo>" e clico em aplicar
    Então o cupom é aplicado com 10% de desconto
    E o desconto exibido é "R$ 10,00"

    Exemplos:
      | codigo     |
      | bemvindo10 |
      | BemVindo10 |
      | bEmViNdO10 |

  @CT-CUP-04 @CA02
  Esquema do Cenário: Espaços no início e no fim do cupom são ignorados
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    Quando informo o cupom "<codigo>" e clico em aplicar
    Então o cupom é aplicado com 10% de desconto

    Exemplos:
      | codigo         |
      | " BEMVINDO10"  |
      | "BEMVINDO10 "  |
      | "  BEMVINDO10  " |
      | " bemvindo10 " |

  @CT-CUP-05 @CA02 @exploratorio
  Cenário: Espaço no meio do código não é ignorado
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    Quando informo o cupom "BEMVINDO 10" e clico em aplicar
    Então é exibida a mensagem "Cupom inválido."
    E nenhum desconto é aplicado

  @CT-CUP-06 @CA03
  Esquema do Cenário: Cupom inexistente
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    Quando informo o cupom "<codigo>" e clico em aplicar
    Então é exibida a mensagem "Cupom inválido."
    E nenhum desconto é aplicado
    E o total é "R$ 119,90"

    Exemplos:
      | codigo        |
      | CUPOMFALSO    |
      | BEMVINDO100   |
      | BEMVINDO1     |
      | 123456        |
      | ' OR '1'='1   |
      | <b>teste</b>  |

  @CT-CUP-07 @CA04
  Cenário: Cupom expirado
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    Quando informo o cupom "VERAO2026" e clico em aplicar
    Então é exibida a mensagem "Cupom expirado."
    E nenhum desconto é aplicado
    E o total é "R$ 119,90"

  @CT-CUP-08 @CA04 @CA02
  Cenário: Cupom expirado digitado em minúsculas e com espaços
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    Quando informo o cupom " verao2026 " e clico em aplicar
    Então é exibida a mensagem "Cupom expirado."
    E nenhum desconto é aplicado

  @CT-CUP-09 @CA05
  Cenário: Campo de cupom fica indisponível enquanto há um cupom aplicado
    # Cobre também a tentativa de reaplicar o mesmo cupom (antigo CT-CUP-11)
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    E que o cupom "BEMVINDO10" está aplicado
    Então o campo para informar outro cupom não está disponível
    E não é possível reaplicar o mesmo cupom
    E o desconto permanece "R$ 10,00"
    Quando removo o cupom atual
    Então o campo de cupom volta a ficar disponível

  @CT-CUP-10 @CA05
  Cenário: Trocar de cupom removendo o atual
    Dado que o cupom "BEMVINDO10" está aplicado no carrinho
    Quando removo o cupom atual
    Então o desconto volta a "R$ 0,00"
    E o total é recalculado sem desconto
    E consigo aplicar outro cupom

  @CT-CUP-12 @exploratorio
  Cenário: Aplicar cupom com campo vazio
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    Quando clico em aplicar sem informar nenhum código
    Então nenhum desconto é aplicado
    E o sistema não apresenta erro inesperado

  @CT-CUP-13 @exploratorio
  Cenário: Desconto é recalculado ao alterar a quantidade com cupom aplicado
    Dado que o cupom "BEMVINDO10" está aplicado com 1 unidade de "Mochila Urbana 20L"
    Quando altero a quantidade para 3
    Então o subtotal é "R$ 300,00"
    E o desconto é "R$ 30,00"
    E o total é "R$ 270,00"

  @CT-CUP-14 @exploratorio
  Cenário: Cupom permanece aplicado ao remover item e some se o carrinho esvaziar
    Dado que o cupom "BEMVINDO10" está aplicado com 2 produtos no carrinho
    Quando removo um dos produtos
    Então o desconto é recalculado sobre o novo subtotal
    Quando removo o último produto
    Então o carrinho aparece vazio e nenhum valor negativo ou inconsistente é exibido
