import { AppConstantes } from './../environments/AppConstante';
import { map } from 'rxjs/operators';
import { Observable } from 'rxjs/Observable';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Task } from './task.model';

@Injectable()
export class AppService {
  constructor(private httpClient: HttpClient) {}

  //   save(Task): Observable<Task> {
  //     return this.httpClient
  //       .post<Task>(`${AppConstantes.urlBaseApi}/`, Task)
  //       .map((res) => res);
  //   }

  //   recuperarSenha(email): Observable<any> {
  //     return this.httpClient
  //       .post<any>(`${Constantes.urlBaseApi}/reset`, { email: email })
  //       .map((res) => res);
  //   }

  //   alterarSenha(senhaForm): Observable<any> {
  //     return this.httpClient
  //       .post<any>(`${Constantes.urlBaseApi}/save_reset`, senhaForm)
  //       .map((res) => res);
  //   }

  //   logout(): Observable<Resultado> {
  //     return this.httpClient
  //       .get<Resultado>(`${Constantes.urlBaseApi}/logout`)
  //       .map((res) => res);
  //   }
}
