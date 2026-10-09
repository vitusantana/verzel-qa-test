import { test, expect, Page } from '@playwright/test';

async function adicionarAoCarrinho(page: Page, produto: string) {
  await page
    .getByRole('article', { name: produto })
    .getByRole('button', { name: 'Adicionar ao carrinho' })
    .click();
}

// Linha do resumo (Subtotal, Desconto, Frete, Total) a partir do rótulo
function linhaResumo(page: Page, rotulo: RegExp) {
  return page.getByText(rotulo).first().locator('..');
}

test('CT-FRE-02 (CA06): frete grátis com subtotal exatamente igual a R$ 200,00', async ({ page }) => {
  // Falha conhecida: ver bugs/BUG-01.md (frete é cobrado no limite exato de R$ 200,00).
  // Quando o bug for corrigido, este teste passa a falhar e a linha abaixo deve ser removida.
  test.fail(true, 'BUG-01: frete cobrado com subtotal igual a R$ 200,00');

  // Dado: 2 unidades de Mochila Urbana 20L (2 x R$ 100,00)
  await page.goto('/');
  await adicionarAoCarrinho(page, 'Mochila Urbana 20L');
  await adicionarAoCarrinho(page, 'Mochila Urbana 20L');
  await page.getByRole('link', { name: /Carrinho/ }).click();
  await expect(page.getByRole('heading', { name: 'Carrinho' })).toBeVisible();

  // Então: o subtotal é R$ 200,00 (esta verificação passa)
  await expect(linhaResumo(page, /^Subtotal$/)).toContainText(/R\$\s*200,00/);

  // E o frete é grátis e o total é R$ 200,00 (aqui o BUG-01 aparece)
  await expect(linhaResumo(page, /^Frete$/)).toContainText('Grátis');
  await expect(linhaResumo(page, /^Total$/)).toContainText(/R\$\s*200,00/);
});