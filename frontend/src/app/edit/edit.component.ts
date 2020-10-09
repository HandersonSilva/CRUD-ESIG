import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss'],
  encapsulation: ViewEncapsulation.None,
})
export class EditComponent implements OnInit {
  senhaForm: FormGroup;
  senhaEnviada: boolean;

  constructor(
    private _formBuilder: FormBuilder,
    public dialogRef: MatDialogRef<EditComponent>
  ) {
    this.senhaForm = this._formBuilder.group({
      task: ['', [Validators.required, Validators.email]],
    });
  }

  ngOnInit(): void {}

  onSave() {
    // this.loginServe
    //   .recuperarSenha(this.senhaForm.value.email)
    //   .subscribe((usuario) => {
    //     this.senhaEnviada = true;
    //   });
  }
  onCancel(): void {
    this.dialogRef.close();
  }
}
