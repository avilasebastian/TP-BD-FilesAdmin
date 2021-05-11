import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { LoginService } from 'src/app/services/login.service';

@Component({
  selector: 'app-registro',
  templateUrl: './registro.component.html',
  styleUrls: ['./registro.component.css']
})
export class RegistroComponent {
  public contrasenia = false;
  public usuarioRepe = false;

  constructor(
    private logserv: LoginService,
    private router: Router
  ) { }

  async registrarUsuario(form) {
    if (form.status == "VALID") {
      this.contrasenia = false;

      if (form.value.password != form.value.repassword) {
        this.contrasenia = true;
      } else {
        if (await this.logserv.login(form.value)) {
          this.usuarioRepe = true;
        } else {
          try {
            this.logserv.registrarUsuario(form.value);
            alert("Se ha registrado correctamente");
            location.reload();
          } catch (error) {
            throw new Error('HTTP.404');
          }
        }
      }
    }
  }
}