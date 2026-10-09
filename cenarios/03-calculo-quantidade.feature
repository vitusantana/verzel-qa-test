@VZS-142 @calculo
Funcionalidade: Cálculo do total e limite de quantidade por produto

  @CT-CAL-01
  Cenário: Total segue a fórmula subtotal - desconto + frete (exemplo da documentação)
    Dado que o carrinho tem 1 "Calça Jeans Slim" e 2 "Boné Aba Curva"
    Quando aplico o cupom "BEMVINDO10"
    Então o subtotal é 239,70
    E o desconto é 23,97
    E o frete é 0,00
    E o total é 215,73

  @CT-CAL-02 @CA11
  Cenário: Precisão decimal - valores com 2 casas, sem erro de ponto flutuante
    Dado que o carrinho tem 3 unidades de "Camiseta Essencial"
    Então o subtotal é "R$ 179,70" (e não 179,70000000000002)
    E ao aplicar "BEMVINDO10" o desconto é "R$ 17,97"
    E o total é "R$ 181,63"

  @CT-CAL-03
  Cenário: Subtotal soma preço unitário vezes quantidade de itens distintos
    Dado que o carrinho tem 1 "Camiseta Essencial", 2 "Kit 3 Pares de Meias" e 1 "Boné Aba Curva"
    Então o subtotal é "R$ 169,60"
    E o frete é "R$ 19,90"

  @CT-QTD-01 @CA10
  Cenário: Adicionar a quantidade máxima permitida (5) na interface
    Quando adiciono 5 unidades de "Boné Aba Curva" ao carrinho
    Então o carrinho aceita as 5 unidades
    E o subtotal é "R$ 249,50"

  @CT-QTD-02 @CA10 @BUG-02
  Cenário: Tentar ultrapassar o limite de 5 unidades na interface
    Dado que o carrinho tem 5 unidades de "Boné Aba Curva"
    Quando tento aumentar a quantidade para 6
    Então o sistema impede ou rejeita a ação
    E a quantidade permanece em 5

  @CT-QTD-03 @CA10 @exploratorio @BUG-02
  Cenário: Limite acumulado ao adicionar o mesmo produto várias vezes
    Dado que o carrinho tem 3 unidades de "Boné Aba Curva"
    Quando clico em "Adicionar ao carrinho" mais 3 vezes para o mesmo produto
    Então o total de unidades do produto nunca ultrapassa 5

  @CT-QTD-04 @CA10 @exploratorio
  Cenário: Limite é por produto, não por pedido
    Quando adiciono 5 unidades de "Boné Aba Curva" e 5 unidades de "Garrafa Térmica 750ml"
    Então ambos os itens são aceitos

  @CT-QTD-05 @CA10 @exploratorio
  Esquema do Cenário: Valores inválidos no campo de quantidade da interface
    Dado que o carrinho tem 1 unidade de "Boné Aba Curva"
    Quando informo a quantidade "<valor>"
    Então o sistema não aceita o valor
    E o carrinho não apresenta total negativo, NaN ou vazio

    Exemplos:
      | valor |
      | 0     |
      | -1    |
      | 2,5   |
      | abc   |
      | (vazio) |
      | 999999 |

  @CT-QTD-06 @exploratorio
  Cenário: Persistência do carrinho ao recarregar a página (mesma aba)
    Dado que o carrinho tem 2 produtos e o cupom "BEMVINDO10" aplicado
    Quando recarrego a página
    Então o carrinho mantém os produtos
    E os valores são recalculados corretamente
