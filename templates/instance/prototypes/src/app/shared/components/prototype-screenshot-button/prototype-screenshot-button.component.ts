import { Component, Input } from '@angular/core';
import { Router } from '@angular/router';

import { PROTOTYPE_SCREENSHOT_BUTTON_CLASS } from '../../constants/prototype-export.constants';
import { PrototypeScreenshotService } from '../../services/prototype-screenshot.service';

@Component({
  selector: 'app-prototype-screenshot-button',
  standalone: true,
  templateUrl: './prototype-screenshot-button.component.html',
  styleUrl: './prototype-screenshot-button.component.scss'
})
export class PrototypeScreenshotButtonComponent {
  @Input({ required: true }) captureTarget!: HTMLElement;

  protected readonly buttonClass = PROTOTYPE_SCREENSHOT_BUTTON_CLASS;
  protected isCapturing = false;

  constructor(
    private readonly screenshotService: PrototypeScreenshotService,
    private readonly router: Router
  ) {}

  protected async downloadScreenshot(): Promise<void> {
    if (!this.captureTarget || this.isCapturing) {
      return;
    }

    this.isCapturing = true;

    try {
      const fileName = this.screenshotService.buildFileName(this.router.url);
      await this.screenshotService.captureAndDownload(this.captureTarget, fileName);
    } finally {
      this.isCapturing = false;
    }
  }
}
