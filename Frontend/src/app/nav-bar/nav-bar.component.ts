import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
	selector: 'app-nav-bar',
	templateUrl: './nav-bar.component.html',
	styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {
	public usuario: string = "usuario: " + sessionStorage.getItem("usuario");
	constructor(
		private router: Router
	) { };

	ngOnInit(): void {
		if(!sessionStorage.getItem("usuario")){
			this.router.navigateByUrl('login')
		}
	}

	cerrar() {
		sessionStorage.clear()
		localStorage.clear()
		this.router.navigateByUrl('login')
	}
}
