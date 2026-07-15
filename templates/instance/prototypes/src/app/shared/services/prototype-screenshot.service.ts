import { Injectable } from '@angular/core';
import { toPng } from 'html-to-image';

import {
  PROTOTYPE_EXPORT_EXCLUDE_CLASS,
  PROTOTYPE_SCREENSHOT_BUTTON_CLASS
} from '../constants/prototype-export.constants';

@Injectable({ providedIn: 'root' })
export class PrototypeScreenshotService {
  async captureAndDownload(captureTarget: HTMLElement, fileName: string): Promise<void> {
    const dataUrl = await toPng(captureTarget, {
      backgroundColor: '#e5e7eb',
      cacheBust: true,
      pixelRatio: window.devicePixelRatio || 1,
      width: captureTarget.scrollWidth,
      height: captureTarget.scrollHeight,
      style: {
        overflow: 'visible'
      },
      filter: (node) => this.shouldIncludeNode(node)
    });

    this.triggerDownload(dataUrl, fileName);
  }

  buildFileName(routePath: string): string {
    const slug =
      routePath
        .replace(/^\//, '')
        .replace(/\//g, '-')
        .replace(/[^a-zA-Z0-9-]/g, '') || 'prototype';

    const date = new Date().toISOString().slice(0, 10);

    return `${slug}-${date}.png`;
  }

  private shouldIncludeNode(node: Node): boolean {
    if (!(node instanceof Element)) {
      return true;
    }

    return (
      !node.classList.contains(PROTOTYPE_EXPORT_EXCLUDE_CLASS) &&
      !node.classList.contains(PROTOTYPE_SCREENSHOT_BUTTON_CLASS)
    );
  }

  private triggerDownload(dataUrl: string, fileName: string): void {
    const link = document.createElement('a');
    link.download = fileName;
    link.href = dataUrl;
    link.click();
  }
}
