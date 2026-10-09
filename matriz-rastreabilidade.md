# Matriz de rastreabilidade (critério de aceite x cenários)

| CA | Cenários |
|----|----------|
| CA01 | CT-CUP-01, 02, 13, CT-API-06, 09 |
| CA02 | CT-CUP-03, 04, 05, 08, CT-API-09 |
| CA03 | CT-CUP-06, CT-API-07, 21 |
| CA04 | CT-CUP-07, 08, CT-API-08, 22 |
| CA05 | CT-CUP-09, 10, CT-API-27 |
| CA06 | CT-FRE-02, 03, 05, 11, CT-API-10 |
| CA07 | CT-FRE-01, 04, 06, 10, 11, CT-API-10 |
| CA08 | CT-FRE-07, 07b, 08, CT-API-11, 11b |
| CA09 | CT-CUP-01, CT-FRE-09, CT-API-06, 11b, 19 |
| CA10 | CT-QTD-01 a 05, CT-API-12, 13 |
| CA11 | CT-CAL-02, CT-API-18 |
| Regras antigas | CT-CLI-01 a 06, CT-API-23, 24 |

Observações:
- CT-CUP-11 foi fundido ao CT-CUP-09 (a interface oculta o campo de cupom quando há cupom aplicado).
- Cenários ligados a bugs possuem a tag @BUG-xx no arquivo .feature.

Automação Playwright (tag @automacao): CT-CUP-01 (UI), CT-FRE-02 (UI), CT-API-12 (API).
