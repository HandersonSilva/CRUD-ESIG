import { AppConstantes } from './../environments/AppConstante';
import { Observable } from 'rxjs/Observable';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Task } from './task.model';
import 'rxjs/add/operator/map';

export interface Result {
  message: string;
  data: Task[];
}

@Injectable()
export class AppService {
  constructor(private httpClient: HttpClient) {}

  save(task): Observable<Result> {
    return this.httpClient
      .post<Result>(`${AppConstantes.urlBaseApi}/task`, task)
      .map((res) => res);
  }

  listFilter(filter): Observable<Result> {
    return this.httpClient
      .get<Result>(`${AppConstantes.urlBaseApi}/task/${filter}`)
      .map((res) => res);
  }

  update(task: Task): Observable<Result> {
    return this.httpClient
      .patch<Result>(`${AppConstantes.urlBaseApi}/task/${task.id}`, task)
      .map((res) => res);
  }

  delete(id): Observable<Result> {
    return this.httpClient
      .delete<Result>(`${AppConstantes.urlBaseApi}/task/${id}`)
      .map((res) => res);
  }

  deleteTaskDone(): Observable<Result> {
    return this.httpClient
      .delete<Result>(`${AppConstantes.urlBaseApi}/task-done`)
      .map((res) => res);
  }
}
