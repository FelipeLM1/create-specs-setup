---
name: system-manual
description: Gera seção do manual do sistema para usuário final com placeholders de imagem, após implementação concluída. Use quando o usuário pedir manual do sistema, documentação de uso, ajuda ao usuário ou system-manual de feature no {{SPECS_REPO_SLUG}}.
---

# Skill: Gerar Seção do Manual do Sistema

## Quando usar

Use esta skill **após a implementação** da feature estar concluída e validada, quando o usuário pedir para documentar a funcionalidade no manual do sistema.

**Gatilhos:**
- "gerar manual de..."
- "documentar no manual a feature de..."
- "criar seção do manual para..."
- "escrever documentação de uso de..."

> ⚠️ **Esta é a última etapa do fluxo.** Só execute após a feature estar implementada e em produção (ou ao menos em homologação validada).

---

## Objetivo

Gerar a seção do manual do sistema referente a esta feature — explicando ao usuário final **o que a funcionalidade faz** e **como usá-la**, com linguagem acessível e referências visuais claras.

---

## Contexto do manual do sistema

O manual do sistema é voltado para o **usuário final** (não para o dev). Ele explica:
- O que cada funcionalidade faz
- Como acessar e usar
- O que esperar em cada situação
- Como interpretar os resultados

**Características do manual:**
- Linguagem clara, sem jargão técnico
- Orientado a ação ("clique em X", "selecione Y")
- Com capturas de tela ou placeholders descritivos onde necessário
- Organizado por fluxo de uso, não por componente técnico

---

## Pré-condições

Antes de gerar, confirme:

- [ ] A feature está implementada e disponível para o usuário
- [ ] Você tem acesso aos artefatos de spec: `sprints/sprint-{N}/features/{slug}/spec/` e `sprints/sprint-{N}/features/{slug}/design/`
- [ ] Você entende o fluxo do usuário na implementação real (pode diferir levemente do protótipo)

---

## Passo a passo

### 1. Revisar os artefatos de spec

Leia rapidamente:
- `sprints/sprint-{N}/features/{slug}/spec/use-case.md` — para entender o fluxo do usuário
- `sprints/sprint-{N}/features/{slug}/spec/business-rules.md` — para entender restrições visíveis ao usuário

Identifique:
- Qual é o fluxo principal do usuário?
- Quais são as ações que o usuário realiza?
- Quais feedbacks o sistema dá?
- Quais erros podem acontecer e o que o usuário deve fazer?

### 2. Estruturar a seção do manual

Use o template `templates/system-manual.md` como base.

**Estrutura obrigatória:**

```
# [Nome da Funcionalidade]

## O que é
Uma frase clara explicando o propósito da funcionalidade para o usuário.

## Como acessar
Caminho de navegação no sistema (Menu > Submenu > Tela).

## Como usar
Passo a passo do fluxo principal, do ponto de vista do usuário.

## O que você verá
Descrição dos elementos visuais principais.

## Situações comuns
Feedbacks, erros e estados que o usuário pode encontrar.

## Perguntas frequentes (se aplicável)
Dúvidas recorrentes com respostas objetivas.
```

### 3. Escrever em linguagem de usuário

**Faça:**
- Use verbos de ação na segunda pessoa: "clique", "selecione", "preencha"
- Seja específico sobre o que aparece na tela: "o botão azul 'Importar' no canto superior direito"
- Explique consequências: "após confirmar, o sistema processará o arquivo e exibirá o resultado"

**Evite:**
- Jargão técnico (endpoint, payload, async, etc.)
- Linguagem passiva ("o arquivo é processado")
- Explicar como funciona internamente

### 4. Inserir placeholders de imagem

Onde houver telas ou fluxos visuais relevantes, insira um placeholder descritivo:

```
[IMAGEM: Tela de upload com o botão "Selecionar arquivo" em destaque, mostrando o estado inicial sem arquivo selecionado]

[IMAGEM: Resultado da importação exibindo resumo — X registros importados com sucesso, Y com erro — e botão "Ver detalhes"]

[IMAGEM: Modal de confirmação solicitando validação antes de sobrescrever dados existentes]
```

**Regras dos placeholders:**
- Descrever o que a imagem deve mostrar com precisão suficiente para alguém tirar o print
- Indicar estados específicos (loading, erro, sucesso, vazio) quando relevante
- Marcar como `[IMAGEM: ...]` para facilitar busca posterior

### 5. Documentar situações de erro

Para cada mensagem de erro que o usuário pode ver, explique:
- O que causou o erro
- O que o usuário deve fazer para resolver

### 6. Revisar com foco no usuário

Leia a seção como se você fosse um usuário que nunca viu a funcionalidade. Pergunte:
- Consigo entender o que fazer só lendo isso?
- Sei o que esperar após cada ação?
- Sei o que fazer se algo der errado?

---

## Validação antes de entregar

- [ ] Linguagem acessível ao usuário final (sem jargão técnico)
- [ ] Fluxo principal documentado passo a passo
- [ ] Situações de erro documentadas com orientação de resolução
- [ ] Placeholders de imagem inseridos onde necessário, com descrição precisa
- [ ] Seção coerente com a implementação real (não apenas com o spec)
- [ ] Status = `rascunho` (avança para `publicado` após revisão)

---

## Saída esperada

Arquivo `sprints/sprint-{N}/features/{slug}/docs/system-manual.md` com:
- Seção completa do manual em linguagem de usuário
- Fluxo de uso passo a passo
- Placeholders de imagem descritivos
- Situações de erro documentadas
- Pronto para incorporar ao manual oficial do sistema

---

## Após gerar — progress e entrega

1. Atualizar `sprints/sprint-{N}/features/{slug}/progress.md` — marcar **D1** `[x]` (skill `feature-progress`)
2. Responder ao usuário conforme `docs/skill-conventions.md`

**Próximo passo:** D2 — UAT / aceite · D4 — encerrar feature
