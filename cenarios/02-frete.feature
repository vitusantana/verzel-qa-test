@VZS-142 @frete
# Na interface, frete de R$ 0,00 é exibido como "Grátis" (AMB-15)
Funcionalidade: Regra de frete grátis
  Como cliente da Verzel Store
  Quero ganhar frete grátis em compras maiores
  Para pagar menos nas minhas compras

  @CT-FRE-01 @CA07
  Cenário: Frete fixo abaixo de R$ 200,00 e valor faltante informado
    Dado que adicionei 1 unidade de "Tênis Casual Urbano" ao carrinho
    Então o subtotal é "R$ 189,90"
    E o frete é "R$ 19,90"
    E o carrinho informa que faltam "R$ 10,10" para o frete grátis
    E o total é "R$ 209,80"

  @CT-FRE-02 @CA06 @automacao @BUG-01
  Cenário: Frete grátis com subtotal exatamente igual a R$ 200,00 (limite inclusivo)
    Dado que adicionei 2 unidades de "Mochila Urbana 20L" ao carrinho
    Então o subtotal é "R$ 200,00"
    E o frete é "Grátis"
    E não é exibido valor faltante para o frete grátis
    E o total é "R$ 200,00"

  @CT-FRE-03 @CA06 @BUG-01
  Cenário: Frete grátis com subtotal exatamente R$ 200,00 composto por outro produto
    Dado que adicionei 4 unidades de "Garrafa Térmica 750ml" ao carrinho
    Então o subtotal é "R$ 200,00"
    E o frete é "Grátis"

  @CT-FRE-04 @CA07
  Cenário: Subtotal logo abaixo do limite (R$ 199,60) cobra frete
    Dado que adicionei 4 unidades de "Boné Aba Curva" ao carrinho
    Então o subtotal é "R$ 199,60"
    E o frete é "R$ 19,90"
    E o carrinho informa que faltam "R$ 0,40" para o frete grátis
    E o total é "R$ 219,50"

  @CT-FRE-05 @CA06
  Cenário: Frete grátis com subtotal acima de R$ 200,00
    Dado que adicionei 1 unidade de "Jaqueta Corta-Vento" ao carrinho
    Então o subtotal é "R$ 229,90"
    E o frete é "Grátis"
    E o total é "R$ 229,90"

  @CT-FRE-06 @CA07
  Cenário: Compra de menor valor possível (R$ 29,90)
    Dado que adicionei 1 unidade de "Kit 3 Pares de Meias" ao carrinho
    Então o frete é "R$ 19,90"
    E faltam "R$ 170,10" para o frete grátis
    E o total é "R$ 49,80"

  @CT-FRE-07 @CA08 @BUG-01
  Cenário: Frete grátis considera o subtotal ANTES do desconto (cupom derruba total abaixo de R$ 200)
    Dado que adicionei 2 unidades de "Mochila Urbana 20L" ao carrinho
    Quando aplico o cupom "BEMVINDO10"
    Então o subtotal é "R$ 200,00"
    E o desconto é "R$ 20,00"
    E o frete é "Grátis"
    E o total é "R$ 180,00"

  @CT-FRE-07b @CA08 @CA09
  Cenário: Frete grátis considera o subtotal antes do desconto (fora do limite exato)
    # Dados escolhidos para não coincidir com o limite exato de R$ 200,00 (ver BUG-01)
    Dado que adicionei 3 unidades de "Boné Aba Curva" e 1 unidade de "Camiseta Essencial" ao carrinho
    Quando aplico o cupom "BEMVINDO10"
    Então o subtotal é "R$ 209,60"
    E o desconto é "R$ 20,96"
    E o frete é "Grátis"
    E o total é "R$ 188,64"

  @CT-FRE-08 @CA08
  Cenário: Subtotal abaixo de R$ 200,00 não ganha frete grátis por causa do cupom
    Dado que adicionei 1 unidade de "Tênis Casual Urbano" ao carrinho
    Quando aplico o cupom "BEMVINDO10"
    Então o frete é "R$ 19,90"
    E o valor faltante é calculado sobre o subtotal "R$ 189,90", ou seja "R$ 10,10"
    E o total é "R$ 190,81"

  @CT-FRE-09 @CA09
  Cenário: Desconto do cupom não incide sobre o frete
    Dado que adicionei 1 unidade de "Mochila Urbana 20L" ao carrinho
    Quando aplico o cupom "BEMVINDO10"
    Então o desconto é "R$ 10,00" (10% de R$ 100,00 e não de R$ 119,90)
    E o frete é "R$ 19,90"
    E o total é "R$ 109,90"

  @CT-FRE-10 @CA07
  Cenário: Valor faltante é atualizado ao adicionar produtos
    Dado que adicionei 1 unidade de "Camiseta Essencial" ao carrinho
    E o carrinho informa que faltam "R$ 140,10"
    Quando aumento a quantidade para 3
    Então o subtotal é "R$ 179,70"
    E faltam "R$ 20,30" para o frete grátis

  @CT-FRE-11 @CA06 @CA07
  Cenário: Frete volta a ser cobrado ao reduzir a quantidade abaixo do limite
    # Dados escolhidos para não coincidir com o limite exato de R$ 200,00 (ver BUG-01)
    Dado que o carrinho tem 3 unidades de "Mochila Urbana 20L"
    E o subtotal é "R$ 300,00" e o frete é "Grátis"
    Quando reduzo a quantidade para 1
    Então o subtotal passa a ser "R$ 100,00"
    E o frete passa a ser "R$ 19,90"
    E o carrinho informa que faltam "R$ 100,00" para o frete grátis
    E o total é "R$ 119,90"

  @CT-FRE-12 @exploratorio
  Cenário: Carrinho vazio não cobra frete
    Dado que o carrinho está vazio
    Então não é cobrado frete
    E o total é "R$ 0,00"
