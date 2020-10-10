import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { EditComponent } from './edit/edit.component';
import { MatTableDataSource } from '@angular/material/table';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { Task } from './task.model';
import { AppService } from './app.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit {
  title = 'frontend';
  displayedColumns: string[] = ['check', 'description', 'edit', 'delete'];
  tasksList: Task[] = [];
  task: Task;
  dataSource: MatTableDataSource<Task>;
  form: FormGroup;
  filter = 'all';

  constructor(
    private _dialog: MatDialog,
    private _appService: AppService,
    private _formBuilder: FormBuilder
  ) {
    this.form = this._formBuilder.group({
      description: [''],
      done: false,
    });
  }

  ngOnInit() {
    this.dataSource = new MatTableDataSource(this.tasksList);
    this.list();
  }

  save() {
    if (this.form.get('description').value === '') {
      return;
    }

    this.task = this.form.getRawValue();
    this.task.filter = this.filter;

    this._appService.save(this.task).subscribe((response) => {
      this.tasksList = response.data;
      this.form.reset({ description: '', done: false });
      this.updateTable();
    });
  }

  list() {
    this._appService.listFilter(this.filter).subscribe((response) => {
      this.tasksList = response.data;
      this.updateTable();
    });
  }

  update(task: Task) {
    task.done = true;
    task.filter = this.filter;

    this._appService.update(task).subscribe((response) => {
      this.tasksList = response.data;
      this.updateTable();
    });
  }

  deleteTask(task: Task) {
    this._appService.delete(task.id).subscribe((response) => {
      this.list();
    });
  }

  deleteTaskDone() {
    this._appService.deleteTaskDone().subscribe((response) => {
      this.list();
    });
  }

  updateTable() {
    this.dataSource.data = this.tasksList;
  }

  setFilter(filterList: string) {
    this.filter = filterList;
    this.list();
  }

  openDialogEdit(task): void {
    const dialogRef = this._dialog.open(EditComponent, {
      width: '450px',
      disableClose: true,
      data: task,
    });

    dialogRef.afterClosed().subscribe((status) => {
      if (status) {
        this.list();
      }
    });
  }
}
