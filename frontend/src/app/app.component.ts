import { Component } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { EditComponent } from './edit/edit.component';

export interface PeriodicElement {
  name: string;
  position: number;
}

const ELEMENT_DATA: PeriodicElement[] = [
  { position: 1, name: 'Hydrogen' },
  { position: 2, name: 'Helium' },
  { position: 3, name: 'Lithium' },
  { position: 4, name: 'Beryllium' },
  { position: 5, name: 'Boron' },
  { position: 6, name: 'Carbon' },
  { position: 7, name: 'Nitrogen' },
  { position: 8, name: 'Oxygen' },
  { position: 9, name: 'Fluorine' },
  { position: 10, name: 'Neon' },
];

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  title = 'frontend';
  displayedColumns: string[] = ['check', 'name', 'edit', 'delete'];
  dataSource = ELEMENT_DATA;
  //panorama_fish_eye

  constructor(private dialog: MatDialog) {}

  add() {
    alert('adicionar tarefa');
  }

  openDialogEdit(task): void {
    const dialogRef = this.dialog.open(EditComponent, {
      width: '450px',
      disableClose: true,
    });

    dialogRef.afterClosed().subscribe((result) => {});
  }
}
