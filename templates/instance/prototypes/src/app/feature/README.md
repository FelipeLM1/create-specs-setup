# Feature prototypes

Crie um diretório por protótipo usando o padrão `{task_ref}-{slug}`.

Exemplo: `100-listagem-usuario`.

Regras:

- Use dados mockados locais.
- Não use autenticação real nem chamadas HTTP reais.
- Modele estados `loading`, `empty`, `error` e `success` quando fizer sentido.
- Marque controles internos com a classe `prototype-export-exclude` para ocultá-los no print (toolbar de estados, notas técnicas, banners de demo, observações dev/PO).
- O botão **Baixar print** aparece automaticamente nas rotas `/prototype/*` (implementado no layout — ver `LAYOUT-SCREENSHOT-WIRE.md`).
- Prints em lote para a pasta da feature: skill `prototype-export-screenshots` ou `npm run export:spec-screenshots -- {slug}`.
