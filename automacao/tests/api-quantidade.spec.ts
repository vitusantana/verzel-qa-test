import { test, expect } from '@playwright/test';

const cliente = { nome: 'Maria Silva', email: 'maria@exemplo.com', cep: '01310-100' };

test.describe('CT-API-12 (CA10): limite de 5 unidades por produto', () => {
  // Controle positivo: 5 unidades (o máximo) é aceito
  test('CT-API-13: quantidade 5 é aceita no /calcular', async ({ request }) => {
    const resposta = await request.post('/api/carrinho/calcular', {
      data: { itens: [{ produtoId: 'P001', quantidade: 5 }] },
    });
    expect(resposta.status()).toBe(200);
    const corpo = await resposta.json();
    expect(corpo.subtotal).toBe(299.5);
  });

  test('CT-API-12: quantidade 6 deve ser rejeitada no /calcular', async ({ request }) => {
    // Falha conhecida: ver bugs/BUG-02.md (a API calcula normalmente com 6 unidades).
    // Quando o bug for corrigido, este teste passa a falhar e a linha abaixo deve ser removida.
    test.fail(true, 'BUG-02: /api/carrinho/calcular não aplica o limite de 5 unidades');

    const resposta = await request.post('/api/carrinho/calcular', {
      data: { itens: [{ produtoId: 'P001', quantidade: 6 }] },
    });
    expect(resposta.status()).toBe(422);
    const corpo = await resposta.json();
    expect(corpo.erro.codigo).toBe('QUANTIDADE_MAXIMA_EXCEDIDA');
  });
});