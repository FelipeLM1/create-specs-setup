---
name: prototype-angular
description: Implementa protótipo navegável de alta fidelidade em Angular no {{SPECS_REPO_SLUG}}/prototypes. Use quando o usuário pedir criar protótipo mockado, mockup navegável, adicionar ao catálogo ou implementar prototype.md em código.
---

# Skill: Criar Protótipo de Alta Fidelidade no {{SPECS_REPO_SLUG}}/prototypes

## Origem do design system

O app `prototypes/` foi montado a partir do **SPA do projeto** (`{{SPA_REPO}}`). Componentes, layout e estilos devem continuar alinhados a esse SPA — **não** importar UI de outro produto.

Se `prototypes/` ainda não existir, o setup (`create-specs-setup`) ou `upgrade-specs` deve criá-lo lendo o SPA no workspace.

## Quando usar esta skill

Use esta skill quando o usuário solicitar:
- Criar novo protótipo de interface
- Gerar protótipo de alta fidelidade
- Desenvolver mockup navegável
- Prototipar tela/fluxo antes da implementação no {{SPA_REPO}}
- Validar UX/UI com stakeholders
- Implementar protótipo mockado
- Adicionar protótipo ao catálogo

**Gatilhos de ativação:**
- "crie um protótipo de..."
- "gerar protótipo para..."
- "prototipar a tela de..."
- "adicionar protótipo de..."
- "mockup navegável de..."

---

## Objetivo

Criar protótipos de interface de alta fidelidade, totalmente desacoplados de backend, usando componentes visuais adaptados do `{{SPA_REPO}}` e dados mockados localmente. O protótipo deve ser navegável, responsivo e validar o fluxo de UX antes da implementação real.

---

## Contexto do ambiente

**Localização:** `{{SPECS_REPO_SLUG}}/prototypes/`

**Stack técnico:**
- Angular 20 standalone
- TypeScript
- SCSS
- Sem Angular Material (opcional, avaliar caso a caso)
- Sem dependências de backend/auth/API

**Estrutura de pastas:**
```
prototypes/
├── src/app/
│   ├── catalog/pages/              # Página inicial do catálogo (compartilhada)
│   ├── prototypes/registry/        # Catálogo central de cards
│   ├── feature/                    # Um protótipo por pasta — isolado por feature
│   │   ├── 100-listagem-usuario/   # {task_ref}-{slug}
│   │   │   ├── data/               # Mock data desta feature
│   │   │   └── pages/              # Componentes desta feature
│   │   └── 101-login/
│   │       ├── data/
│   │       └── pages/
│   ├── shared/
│   │   ├── components/             # Componentes UI adaptados do {{SPA_REPO}}
│   │   └── models/                 # Interfaces/tipos compartilhados
│   └── core/models/                # Modelos centrais (PrototypeCard, etc.)
```

**Convenção de pasta por feature:** `feature/{task_ref}-{slug}/`

| Parte | Exemplo | Origem |
|-------|---------|--------|
| `task_ref` | `100`, `101` | Issue/task GitLab (ou ID acordado pelo time) |
| `slug` | `listagem-usuario`, `login` | Slug da feature em kebab-case |

Config em `sdd.config.yaml` → `prototype.feature_base_path` e `prototype.feature_folder_pattern`.

**Design system de referência:** `{{SPA_REPO}}` (reutilizar componentes visuais sem lógica de negócio)

---

## Instruções passo a passo

### 1. Entender o requisito de protótipo

**Perguntas essenciais:**
1. Qual o **task_ref** (número da issue GitLab ou ID da task)? — obrigatório para nomear a pasta
2. Qual o **slug** da feature em kebab-case? (ex.: `listagem-usuario`)
3. Qual a **sprint** (`N` de `sprints/sprint-{N}/`)? Default: `workflow.current_sprint` em `sdd.config.yaml`
4. Qual o nome/título do protótipo?
5. Quais os principais componentes visuais necessários? (tabelas, cards, filtros, gráficos, etc.)
6. Quais estados precisam ser representados? (loading, empty, error, success)

**Nome da pasta:** `{task_ref}-{slug}` → ex.: `100-listagem-usuario`, `101-login`

**Se informações estiverem faltando:** pergunte antes de prosseguir (máx. 3). Ver `docs/skill-conventions.md`.

---

### 2. Criar o registro do protótipo no catálogo

**Arquivo:** `src/app/prototypes/registry/prototype-catalog.data.ts`

**Modelo:** `src/app/core/models/prototype-card.model.ts` — campo obrigatório `sprint: number` (badge + filtro na home).

**Catálogo (home):** busca por nome/descrição/tag + filtro por sprint (chips). Referência de scaffold: `create-specs-setup/templates/instance/prototypes/`.

**Adicionar novo card:**
```typescript
export const prototypeCatalog: PrototypeCard[] = [
  // ... protótipos existentes
  {
    id: '100-listagem-usuario',              // = nome da pasta em feature/
    title: 'Listagem de Usuários',           // Título descritivo
    description: 'Descrição objetiva...',    // 1-2 frases sobre o objetivo
    route: '/prototype/100-listagem-usuario', // = /prototype/{task_ref}-{slug}
    status: 'draft',                          // 'draft' | 'ready' | 'validated'
    sprint: 52,                               // = N de sprints/sprint-{N}/ (obrigatório)
    taskRef: '100',                           // Número/ID da task
    taskRequirement: 'GitLab #100 — listagem de usuários',
    tags: ['tag1', 'tag2'],                   // Tags para categorização / busca
    updatedAt: 'YYYY-MM-DD'                   // Data ISO format
  }
];
```

**Regra:** se a feature está em `sprints/sprint-{N}/`, preencher `sprint: N`. Se ainda está em `sprints/in-progress/`, **omitir** `sprint` (badge "Em andamento" no catálogo).

---

### 3. Criar pasta isolada da feature

**Pasta:** `src/app/feature/{task_ref}-{slug}/`

Criar subpastas `data/` e `pages/`. Opcional: `README.md` com link da issue e notas.

---

### 4. Criar mock data realista

**Arquivo:** `src/app/feature/{task_ref}-{slug}/data/{slug}-mock.data.ts`

**Princípios de mock data:**
- Dados realistas e variados (não repetir "Test 1", "Test 2")
- Incluir edge cases: strings longas, valores extremos, campos vazios
- Modelar exatamente como virá da API real (mesmo formato)
- Usar nomes/valores brasileiros quando aplicável ao contexto

**Exemplo:**
```typescript
export interface ProductMock {
  id: string;
  partNumber: string;
  description: string;
  stock: number;
  region: string;
  status: 'active' | 'inactive' | 'pending';
}

export const productsMockData: ProductMock[] = [
  {
    id: 'prod-001',
    partNumber: 'MB-AX340-BR',
    description: 'Mainboard AX Series - Variante brasileira com adaptador 127/220V',
    stock: 47,
    region: 'LATAM',
    status: 'active'
  },
  {
    id: 'prod-002',
    partNumber: 'LCD-15',
    description: 'Display 15"',
    stock: 0,
    region: 'EMEA',
    status: 'inactive'
  }
  // ... mais exemplos
];
```

---

### 5. Identificar componentes visuais necessários

**Componentes já disponíveis em `shared/components/`:**
- `input-search` - busca com botão
- `custom-input` - input controlável com ControlValueAccessor
- `custom-select` - select dropdown simples
- `no-data-avaliable` - estado vazio

**Se precisar de novos componentes do {{SPA_REPO}}:**

1. **Localizar o componente original** em `/{{SPA_REPO}}/src/app/shared/components/`
2. **Copiar e adaptar** (remover dependências):
   - Remover imports de services de auth, API, HTTP
   - Remover guards, interceptors, environment
   - Simplificar lógica complexa para mock
   - Manter apenas funcionalidade visual
3. **Criar versão standalone** em `prototypes/src/app/shared/components/`
4. **Verificar estilos:** copiar `.scss` e adaptar referências de variáveis globais se necessário

**Princípios de adaptação:**
- Componente deve ser 100% standalone
- Usar `@Input()` e `@Output()` para comunicação
- Sem lógica de negócio, apenas apresentação
- Sem chamadas HTTP diretas

---

### 6. Criar o componente da página do protótipo

**Arquivo:** `src/app/feature/{task_ref}-{slug}/pages/{slug}-prototype-page.component.ts`

**Template do componente:**
```typescript
import { CommonModule } from '@angular/core';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';

// Imports de componentes shared (3 níveis até src/app/)
import { InputSearchComponent } from '../../../shared/components/input-search/input-search.component';
import { NoDataAvaliableComponent } from '../../../shared/components/no-data-avaliable/no-data-avaliable.component';

// Mock data (mesma feature)
import { mockData } from '../data/{slug}-mock.data';

type PageState = 'loading' | 'empty' | 'error' | 'success';

@Component({
  selector: 'app-{feature-name}-prototype-page',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterLink,
    InputSearchComponent,
    NoDataAvaliableComponent
    // ... outros componentes necessários
  ],
  templateUrl: './{feature-name}-prototype-page.component.html',
  styleUrl: './{feature-name}-prototype-page.component.scss'
})
export class {FeatureName}PrototypePageComponent {
  // Estado da página (para simulação de loading/error/etc)
  protected state: PageState = 'success';

  // Mock data
  protected readonly rawData = mockData;
  protected filteredData = [...this.rawData];

  // Métodos para manipulação de estado
  protected setState(state: PageState): void {
    this.state = state;
  }

  // Métodos para filtros/busca
  protected handleSearch(query: string): void {
    // Lógica de filtro local
  }
}
```

---

### 7. Criar o template HTML

**Arquivo:** `src/app/feature/{task_ref}-{slug}/pages/{slug}-prototype-page.component.html`

**Estrutura padrão:**
```html
<main class="prototype-page">
  <!-- Header com breadcrumb e título -->
  <header class="page-header">
    <a routerLink="/" class="back-link">← Voltar para catálogo</a>
    <h1>Protótipo: {Título}</h1>
    <p>{Descrição do objetivo do protótipo}</p>
  </header>

  <!-- Controles para alternar estados visuais -->
  <section class="state-switch">
    <span>Estados de visualização:</span>
    <div>
      <button type="button" (click)="setState('loading')">Loading</button>
      <button type="button" (click)="setState('empty')">Empty</button>
      <button type="button" (click)="setState('error')">Error</button>
      <button type="button" (click)="setState('success')">Success</button>
    </div>
  </section>

  <!-- KPIs/Cards informativos (se aplicável) -->
  <section class="kpi-section">
    <!-- ... -->
  </section>

  <!-- Filtros e controles -->
  <section class="filters-section">
    <app-input-search 
      placeholder="Buscar..." 
      (searchQuerySubmitted)="handleSearch($event)" 
    />
    <!-- Outros filtros -->
  </section>

  <!-- Renderização condicional por estado -->
  @if (state === 'loading') {
    <div class="feedback-state loading">Carregando dados mockados...</div>
  }

  @if (state === 'empty') {
    <app-no-data-avaliable message="Nenhum resultado encontrado" />
  }

  @if (state === 'error') {
    <div class="feedback-state error">Erro ao renderizar protótipo.</div>
  }

  @if (state === 'success') {
    <!-- Conteúdo principal: tabelas, cards, listas, etc -->
    <section class="content-section">
      <!-- ... -->
    </section>
  }

  <!-- Footer com observações -->
  <footer class="prototype-notes">
    <p><strong>Nota:</strong> este é um protótipo de alta fidelidade sem integração com backend.</p>
  </footer>
</main>
```

**Princípios de markup:**
- HTML semântico (`<main>`, `<section>`, `<article>`, `<header>`, `<footer>`)
- Acessibilidade: `aria-label` quando necessário, navegação por teclado
- Usar control flow Angular moderno (`@if`, `@for`) ao invés de `*ngIf`, `*ngFor`
- Evitar divs aninhadas desnecessárias

---

### 8. Criar estilos SCSS responsivos

**Arquivo:** `src/app/feature/{task_ref}-{slug}/pages/{slug}-prototype-page.component.scss`

**Princípios de estilização:**
- Mobile-first: estilos base para mobile, media queries para desktop
- Usar variáveis de cor consistentes com o {{SPA_REPO}}
- Grid/Flexbox para layouts responsivos
- Evitar magic numbers (usar variáveis ou cálculos semânticos)
- Border-radius, shadows e espaçamentos consistentes

**Template base:**
```scss
:host {
  display: block;
  min-height: 100vh;
  background: #f8fafc;
}

.prototype-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem 2.5rem;
  color: #1f2937;
}

.page-header {
  margin-bottom: 1.5rem;

  .back-link {
    display: inline-block;
    text-decoration: none;
    color: #166534;
    font-weight: 600;
    margin-bottom: 0.8rem;
  }

  h1 {
    margin: 0;
    font-size: 1.7rem;
  }

  p {
    margin-top: 0.6rem;
    color: #4b5563;
    max-width: 780px;
  }
}

.state-switch {
  display: flex;
  gap: 1rem;
  align-items: center;
  margin-bottom: 1.2rem;

  button {
    border: 1px solid #d1d5db;
    background: #ffffff;
    border-radius: 8px;
    padding: 0.45rem 0.8rem;
    cursor: pointer;

    &:hover {
      background: #f3f4f6;
    }
  }
}

// Responsividade
@media (max-width: 900px) {
  .prototype-page {
    padding: 1rem;
  }

  // Ajustes de grid para mobile
}

@media (max-width: 600px) {
  // Ajustes adicionais para telas pequenas
}
```

**Paleta de cores base (alinhada ao {{SPA_REPO}}):**
```scss
// Cores primárias do design system (ajustar ao SPA)
$brand-primary: #2563eb;
$brand-dark: #1e3a5f;

// Neutros
$gray-50: #f9fafb;
$gray-100: #f3f4f6;
$gray-200: #e5e7eb;
$gray-300: #d1d5db;
$gray-600: #4b5563;
$gray-900: #111827;

// Estados
$success: #16a34a;
$warning: #f59e0b;
$error: #dc2626;
$info: #3b82f6;
```

---

### 9. Adicionar rota no arquivo de rotas

**Arquivo:** `src/app/app.routes.ts`

**Adicionar nova rota:**
```typescript
import { {FeatureName}PrototypePageComponent } from './feature/100-listagem-usuario/pages/{slug}-prototype-page.component';

export const routes: Routes = [
  {
    path: '',
    component: LayoutComponent,
    children: [
      { path: '', component: PrototypeCatalogPageComponent },
      {
        path: 'prototype/100-listagem-usuario',  // = {task_ref}-{slug}
        component: {FeatureName}PrototypePageComponent
      },
      { path: '**', redirectTo: '' }
    ]
  }
];
```

---

### 10. Testar o protótipo localmente

**Comandos de teste:**
```bash
cd {{SPECS_REPO_SLUG}}/prototypes
npm start
```

**Checklist de validação visual:**
- [ ] Protótipo aparece no catálogo inicial
- [ ] Card exibe título, descrição, badge **Sprint {N}**, status e tags corretos
- [ ] Busca por nome no catálogo encontra o card
- [ ] Filtro por sprint no catálogo isola o card
- [ ] Clicar no card navega para a página do protótipo
- [ ] Todos os 4 estados (loading, empty, error, success) renderizam corretamente
- [ ] Filtros/busca da tela do protótipo funcionam com mock data
- [ ] Layout responsivo funciona em mobile (DevTools responsive mode)
- [ ] Botão "Voltar ao catálogo" funciona
- [ ] Não há erros no console do navegador
- [ ] Não há imports de serviços de backend/auth

---

### 11. Documentar observações técnicas

**Se houver decisões de design ou limitações, documentar:**
- Componentes que foram simplificados (e por quê)
- Comportamentos mockados que divergem da implementação real
- Edge cases que não foram cobertos no mock
- Sugestões de melhoria para a implementação real

**Local:** `src/app/feature/{task_ref}-{slug}/README.md` ou comentário no topo do `.ts` principal.

---

## Checklist de qualidade final

Antes de considerar o protótipo completo, valide:

### Código
- [ ] Componente TypeScript standalone com imports corretos
- [ ] Nenhuma dependência de `HttpClient`, auth, guards, interceptors
- [ ] Mock data realista e variado
- [ ] Tipagem explícita (evitar `any`)
- [ ] Nomes semânticos e descritivos
- [ ] Métodos pequenos (< 20 linhas cada)
- [ ] Sem lógica complexa de negócio (apenas apresentação)

### Interface
- [ ] Layout responsivo (mobile, tablet, desktop)
- [ ] Estados visuais implementados (loading, empty, error, success)
- [ ] Componentes visuais alinhados ao design do {{SPA_REPO}}
- [ ] Feedback visual para ações do usuário (hover, click, etc)
- [ ] Acessibilidade básica (navegação por teclado, labels)

### Integração
- [ ] Card registrado em `prototype-catalog.data.ts` com `sprint` preenchido
- [ ] Rota adicionada em `app.routes.ts`
- [ ] Protótipo acessível a partir do catálogo inicial (busca + filtro sprint)
- [ ] Navegação funcional (voltar ao catálogo)

### Processo
- [ ] Pasta `feature/{task_ref}-{slug}/` criada com `data/` e `pages/`
- [ ] Status inicial: `'draft'`
- [ ] `sprint` = N da feature (`sprints/sprint-{N}/`)
- [ ] `taskRef` e `taskRequirement` preenchidos no card
- [ ] Tags descritivas adicionadas
- [ ] Data de criação registrada

---

## Exemplos práticos

### Exemplo 1: Protótipo de dashboard com cards

**Requisito:** Dashboard de vendas com 3 cards de métrica e tabela filtrada.

**Passos resumidos:**
1. Mock data: array de pedidos com status, região, valor
2. Componentes: `custom-select` (filtro região), `input-search`, tabela customizada
3. Estados: loading (spinner), empty (sem resultados), success (tabela populada)
4. Layout: grid de cards (3 colunas), filtros em linha, tabela full-width

### Exemplo 2: Protótipo de formulário multi-step

**Requisito:** Wizard de 3 etapas para criar pedido.

**Passos resumidos:**
1. Mock data: estrutura de pedido com etapas
2. Componentes: `custom-input`, `custom-select`, stepper visual
3. Estados: validação por etapa (campos obrigatórios), confirmação final
4. Layout: stepper no topo, formulário centralizado, botões de navegação

---

## Anti-patterns a evitar

❌ **NÃO fazer:**
- Copiar código de serviços de backend/auth
- Usar `HttpClient` ou fazer chamadas reais de API
- Implementar lógica de negócio complexa
- Criar guards ou interceptors
- Usar bibliotecas pesadas desnecessárias (charts complexos sem necessidade)
- Mock data genérico ("Test 1", "Test 2", "Test 3")
- Layout fixo não responsivo
- Ignorar estados de loading/error/empty

✅ **Fazer:**
- Código 100% frontend mockado
- Componentes standalone simples
- Mock data realista e variado
- Layout responsivo mobile-first
- Estados visuais explícitos e testáveis
- Reutilizar componentes visuais do {{SPA_REPO}} adaptados
- Foco em validação de UX, não em regra de negócio

---

## Troubleshooting comum

### Erro: "Cannot find module '@angular/...'"
**Solução:** verificar que todas as dependências necessárias estão em `package.json`. Rodar `npm install` se necessário.

### Componente não renderiza
**Solução:** verificar que o componente está declarado em `imports: []` no decorator `@Component` da página.

### Estilos não aplicam
**Solução:** verificar caminho do `styleUrl` e garantir que arquivo `.scss` existe. Usar `:host` para estilos no nível do componente.

### Rota não funciona
**Solução:** verificar que a rota foi adicionada em `app.routes.ts` e que o `path` corresponde ao `route` no card do catálogo.

---

## Saída esperada

Ao final da execução desta skill, você deve ter:

1. **Novo card no catálogo** visível na home
2. **Página de protótipo navegável** acessível via card
3. **4 estados visuais** (loading, empty, error, success) funcionando
4. **Mock data realista** representando o cenário de uso
5. **Layout responsivo** testado em mobile e desktop
6. **Código limpo** sem dependências de backend/auth
7. **Componentes reutilizáveis** adaptados do {{SPA_REPO}} quando aplicável

---

## Após gerar — progress e entrega

1. Atualizar `sprints/sprint-{N}/features/{slug}/progress.md` — marcar **B5** `[x]`, link do catálogo na nota (skill `feature-progress`)
2. Responder ao usuário conforme `docs/skill-conventions.md`

**Próximo passo:** B5 — validação com stakeholder (registrar em progress)

---

## Atualização de templates (quando aplicável)

Após criar protótipos, considere atualizar:
- `templates/prototype.md` - adicionar campo `prototypeId` e `catalogRoute`
- `templates/sprint-task.md` - adicionar seção "Protótipo de referência" com link

---

**Versão:** 1.0  
**Última atualização:** 2026-05-24  
**Versão skill:** 1.0
