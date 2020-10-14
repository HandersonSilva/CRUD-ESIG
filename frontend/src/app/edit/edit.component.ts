import { Component, Inject, OnInit, ViewEncapsulation } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { AppService } from '../app.service';

import { Task } from '../task.model';

@Component({
  selector: 'edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss'],
  encapsulation: ViewEncapsulation.None,
})
export class EditComponent implements OnInit {
  form: FormGroup;
  task: Task;

  constructor(
    private _formBuilder: FormBuilder,
    private _appService: AppService,
    private _dialogRef: MatDialogRef<EditComponent>,
    @Inject(MAT_DIALOG_DATA) data
  ) {
    if (data) {
      this.task = data;
    }

    this.form = this._formBuilder.group({
      id: '',
      description: ['', Validators.required],
      done: false,
    });
  }

  ngOnInit(): void {
    this.form.patchValue(this.task);
  }

  onSave() {
    if (this.form.get('description').value === '') {
      return;
    }

    this.task = this.form.getRawValue();

    this._appService.update(this.task).subscribe((response) => {
      this._dialogRef.close(true);
    });
  }

  onCancel(): void {
    this._dialogRef.close(false);
  }
}
