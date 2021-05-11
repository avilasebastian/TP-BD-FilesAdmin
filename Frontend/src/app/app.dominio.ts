import { Injectable } from '@angular/core';

@Injectable({providedIn: 'root'})
export class MiBaul {
    public servicio: any;
    public argumento: number;
    public esModificable: boolean = true;

    public setComponente(
        argumento: number = null,
        esModificable: boolean = true
    ): void {
        this.argumento = argumento;
        this.esModificable = esModificable;
    }
}

export class IDocumento {
    public id_contenido: string = "";
    public titulo: string = "";
    public fecha_publicacion: string = new Date().toISOString().slice(0, 10);
    public extensionArchivo: string = "";
    public categoria: ICategoria[] = [];
    public cantidadDescargas: number = 0;
    public propietario: Propietario = new Propietario();
    public activo: boolean = true;
}

export interface ICategoria {
    id_categoria: string;
    descripcion: string;
}

export class Propietario {
    nombreDeUsuario: string = "";
}

export interface Ilogin {
    nombreDeUsuario: string,
    password: string
}

export interface Iloginresponse {
}

export interface Iregistro {
    nombreDeUsuario: string,
    password: string,
    nombre: string,
    apellido: string,
    fechaDeNacimiento: string
}

export class Descarga{
    velocidad:number = 0;
    nombre:string = "";
    idDocumento:string = "";
  }