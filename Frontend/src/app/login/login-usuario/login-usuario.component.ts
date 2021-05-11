import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { LoginService } from 'src/app/services/login.service';


@Component({
  selector: 'app-login-usuario',
  templateUrl: './login-usuario.component.html',
  styleUrls: ['./login-usuario.component.css']
})
export class LoginUsuarioComponent implements OnInit {
  public logInInvalido = false
  public recordar = false

  constructor(
    private logserv: LoginService,
    private router: Router
  ) { }

  async ngOnInit() {
    var datoUsuario = JSON.parse(localStorage.getItem('usr'));
    console.log(datoUsuario)
    if (datoUsuario) {
      sessionStorage.setItem("usuario", datoUsuario.nombreDeUsuario);
      if (!await this.logserv.login(datoUsuario)){
        sessionStorage.setItem("usuario", datoUsuario.usuario);
        this.router.navigateByUrl('lista');
      }
    }
  };

  async onLogin(form) {
    if (form.status == "VALID") {
      try {
        if (!await this.logserv.login(form.value)) {
          this.logInInvalido = true
          localStorage.removeItem('usr');
        } else {
          sessionStorage.setItem("usuario", form.value.nombreDeUsuario);
          if (this.recordar)
            localStorage.setItem('usr', '{"usuario":"' + form.value.nombreDeUsuario + '", "pass":"' + form.value.password + '"}');
          else
            localStorage.removeItem('usr');

          this.router.navigateByUrl('lista');
        }
      } catch (error) {
        this.logInInvalido = true
      }
    }
  }

  valueChange($event) {
    this.recordar = $event.checked;
  }
}
