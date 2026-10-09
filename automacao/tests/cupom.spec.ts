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

test('CT-CUP-01 (CA01, CA09): aplicar o cupom BEMVINDO10 reduz 10% do subtotal', async ({ page }) => {
  // Dado: 1 Calça Jeans Slim e 2 Bonés Aba Curva no carrinho
  await page.goto('/');
  await adicionarAoCarrinho(page, 'Calça Jeans Slim');
  await adicionarAoCarrinho(page, 'Boné Aba Curva');
  await adicionarAoCarrinho(page, 'Boné Aba Curva');

  // Navegação sem recarregar: o carrinho fica só na aba do navegador
  await page.getByRole('link', { name: /Carrinho/ }).click();
  await expect(page.getByRole('heading', { name: 'Carrinho' })).toBeVisible();

  // Quando: informo o cupom e aplico
  await page.getByLabel('Cupom de desconto').fill('BEMVINDO10');
  await page.getByRole('button', { name: 'Aplicar cupom' }).click();

  // Então: valores do resumo conforme a documentação
  await expect(linhaResumo(page, /^Subtotal$/)).toContainText(/R\$\s*239,70/);
await expect(linhaResumo(page, /^Desconto/)).toContainText(/R\$\s*23,97/);
await expect(linhaResumo(page, /^Frete$/)).toContainText('Grátis');
await expect(linhaResumo(page, /^Total$/)).toContainText(/R\$\s*215,73/);
});