import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

import { BehaviorSubject } from 'rxjs';
import { REST_SERVER_URL } from 'src/configuration';
import { Descarga, ICategoria, IDocumento } from '../app.dominio';

@Injectable({
  providedIn: 'root'
})
export class DocumentoService {
  authSubject = new BehaviorSubject(false);

  constructor(private httpClient: HttpClient) { }

  async obtenerCategorias(): Promise<ICategoria[]> {
    return await this.httpClient.get<ICategoria[]>(REST_SERVER_URL + '/categorias').toPromise()
  }

  async obtenerExtensiones(): Promise<String[]> {
    return await this.httpClient.get<String[]>(REST_SERVER_URL + '/extensiones').toPromise()
  }

  async obtenerListaDocumentos(): Promise<IDocumento[]> {
    return await this.httpClient.get<IDocumento[]>(REST_SERVER_URL + '/documentos').toPromise()
  }

  async obtenerDocumento(nroarchivo): Promise<IDocumento> {
    return await this.httpClient.get<IDocumento>(REST_SERVER_URL + '/ver/' + nroarchivo).toPromise();
  }

  async eliminarDocumento(nroarchivo): Promise<void> {
    await this.httpClient.put(REST_SERVER_URL + '/eliminarDocumento/' + nroarchivo, nroarchivo).toPromise()
  }

  async agregarDocumento(archivo: FormData): Promise<IDocumento> {
    return await this.httpClient.post<IDocumento>(REST_SERVER_URL + '/agregarDocumento', archivo).toPromise()
  }

  async modificarDocumento(archivo: FormData): Promise<IDocumento> {
    return await this.httpClient.post<IDocumento>(REST_SERVER_URL + '/modificarDocumento', archivo).toPromise()
  }

  async descargarDocumento(archivo): Promise<File> {
    return await this.httpClient.get<File>(REST_SERVER_URL + '/Archivo/' + archivo).toPromise()
  }

  async crearDescarga(descarga:Descarga): Promise<void> {
    return await this.httpClient.put<void>(REST_SERVER_URL + '/crearDescarga/' + descarga.velocidad +'/'+descarga.nombre+'/'+descarga.idDocumento, descarga).toPromise()
  }  
}


