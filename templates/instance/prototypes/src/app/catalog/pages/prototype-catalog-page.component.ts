import { DatePipe, NgClass } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';

import { HeaderComponent } from '../../layout/components/header/header.component';
import { PrototypeCard } from '../../core/models/prototype-card.model';
import { prototypeCatalog } from '../../prototypes/registry/prototype-catalog.data';

/** `null` = todas; `'in-progress'` = sem sprint; number = sprint N */
export type SprintFilter = number | 'in-progress' | null;

@Component({
  selector: 'app-prototype-catalog-page',
  standalone: true,
  imports: [DatePipe, FormsModule, NgClass, RouterLink, HeaderComponent],
  templateUrl: './prototype-catalog-page.component.html',
  styleUrl: './prototype-catalog-page.component.scss'
})
export class PrototypeCatalogPageComponent implements OnInit {
  protected readonly allCards: PrototypeCard[] = prototypeCatalog;

  protected searchQuery = '';
  protected selectedSprint: SprintFilter = null;

  ngOnInit(): void {
    console.info(
      `[prototypes] catalog loaded: ${this.allCards.length} cards`,
      this.allCards.map((card) =>
        card.sprint != null ? `${card.id} (sprint ${card.sprint})` : `${card.id} (in-progress)`
      )
    );
  }

  protected get availableSprints(): number[] {
    const sprints = new Set(
      this.allCards
        .map((card) => card.sprint)
        .filter((sprint): sprint is number => sprint != null)
    );
    return [...sprints].sort((a, b) => b - a);
  }

  protected get hasInProgressCards(): boolean {
    return this.allCards.some((card) => card.sprint == null);
  }

  protected get filteredCards(): PrototypeCard[] {
    const query = this.searchQuery.trim().toLowerCase();

    return this.allCards.filter((card) => {
      if (!this.matchesSprintFilter(card)) {
        return false;
      }
      if (!query) {
        return true;
      }
      return (
        card.title.toLowerCase().includes(query) ||
        card.description.toLowerCase().includes(query) ||
        card.id.toLowerCase().includes(query) ||
        card.tags.some((tag) => tag.toLowerCase().includes(query))
      );
    });
  }

  protected selectSprint(sprint: SprintFilter): void {
    this.selectedSprint = sprint;
  }

  protected clearFilters(): void {
    this.searchQuery = '';
    this.selectedSprint = null;
  }

  protected sprintBadgeLabel(card: PrototypeCard): string {
    return card.sprint != null ? `Sprint ${card.sprint}` : 'Em andamento';
  }

  protected getStatusLabel(status: PrototypeCard['status']): string {
    const labels: Record<PrototypeCard['status'], string> = {
      draft: 'Em construção',
      ready: 'Pronto para refinamento',
      validated: 'Validado'
    };
    return labels[status];
  }

  private matchesSprintFilter(card: PrototypeCard): boolean {
    if (this.selectedSprint === null) {
      return true;
    }
    if (this.selectedSprint === 'in-progress') {
      return card.sprint == null;
    }
    return card.sprint === this.selectedSprint;
  }
}
