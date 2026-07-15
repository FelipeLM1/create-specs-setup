# Layout — wire do botão Baixar print

Ao montar o layout do protótipo (derivado do SPA), integrar o botão de captura assim.

## 1. Area de captura

A área de conteúdo (sem sidebar) deve ter `#captureArea` / template ref e a classe `content`:

```html
<section #captureArea class="content" [ngClass]="{ retracted: !isExpandedSidebar }">
  <router-outlet />
</section>

@if (isPrototypeRoute && captureTarget) {
  <app-prototype-screenshot-button [captureTarget]="captureTarget" />
}
```

## 2. Component TypeScript (trecho)

```typescript
import { PrototypeScreenshotButtonComponent } from '../shared/components/prototype-screenshot-button/prototype-screenshot-button.component';

@ViewChild('captureArea') captureArea?: ElementRef<HTMLElement>;

protected isPrototypeRoute = false;

protected get captureTarget(): HTMLElement | null {
  return this.captureArea?.nativeElement ?? null;
}

// Em NavigationEnd / ngOnInit:
private syncPrototypeRoute(url: string): void {
  this.isPrototypeRoute = url.startsWith('/prototype/');
}
```

Importar `PrototypeScreenshotButtonComponent` no array `imports` do layout.

## 3. Arquivos a copiar do scaffold

Ver `README.md` neste diretório (`templates/instance/prototypes/`).
