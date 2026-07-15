export type PrototypeStatus = 'draft' | 'ready' | 'validated';

export interface PrototypeCard {
  /** Igual ao nome da pasta em feature/ — ex.: 100-listagem-usuario */
  id: string;
  title: string;
  description: string;
  route: string;
  status: PrototypeStatus;
  /**
   * Número da sprint da feature (`sprints/sprint-{N}/`).
   * Omitir quando a feature ainda está em `sprints/in-progress/`.
   */
  sprint?: number;
  /** Referência da task — ex.: 100 (issue GitLab) */
  taskRef?: string;
  taskRequirement: string;
  tags: string[];
  updatedAt: string;
}
