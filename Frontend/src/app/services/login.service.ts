import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

import { BehaviorSubject } from 'rxjs';
import { REST_SERVER_URL } from 'src/configuration';
import { Ilogin, Iregistro } from '../app.dominio';

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  authSubject = new BehaviorSubject(false);

  constructor(private httpClient: HttpClient) { }

  async login(user: Ilogin): Promise<boolean> {
    const userValido = await this.httpClient.post<boolean>(REST_SERVER_URL + '/login', user).toPromise()
    console.log(userValido)
    return userValido
  }

  async registrarUsuario(user: Iregistro): Promise<void> {
    await this.httpClient.post(REST_SERVER_URL + '/registrarUsuario', user).toPromise()
  }
}
