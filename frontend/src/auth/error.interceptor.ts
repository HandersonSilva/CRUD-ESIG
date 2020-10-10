import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HttpErrorResponse,
} from '@angular/common/http';
import 'rxjs/add/operator/do';
import { EMPTY, TimeoutError } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Injectable()
export class ErrorInterceptor implements HttpInterceptor {
  constructor() {}

  intercept(
    request: HttpRequest<any>,
    next: HttpHandler
  ): Observable<HttpEvent<any>> {
    return next
      .handle(request)
      .pipe(
        catchError((error: HttpErrorResponse) =>
          this.handleError(request.url, error)
        )
      );
  }

  handleError(url, errorResponse): Observable<HttpEvent<any>> {
    if (errorResponse instanceof TimeoutError) {
      return EMPTY;
    }

    switch (errorResponse.status) {
      case 401:
        if (errorResponse.error.message !== undefined) {
          console.log(`Error: ${errorResponse.message}`);
        }
        break;
      case 403:
        if (errorResponse.error.message !== undefined) {
          console.log(`Error: ${errorResponse.message}`);
        }

        break;
      case 404:
        if (errorResponse.error.message !== undefined) {
          console.log(`Error: ${errorResponse.message}`);
        }
        break;
      case 400:
        if (errorResponse.error.message !== undefined) {
          console.log(`Error: ${errorResponse.message}`);
        }
        break;
      case 409:
        if (errorResponse.error.message !== undefined) {
          console.log(`Error: ${errorResponse.message}`);
        }
    }

    return EMPTY;
  }
}
