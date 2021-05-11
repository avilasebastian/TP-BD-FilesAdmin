import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { LoginComponent } from './login/login.component';


import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import {
	MatCardModule,
	MatTabsModule,
	MatFormFieldModule,
	MatInputModule,
	MatButtonModule,
	MatCheckboxModule,
	MatIconModule,
	MatSelectModule,
	MatSortModule,
	MatTableModule,
	MatSort
} from '@angular/material';
import { LstDocumentosComponent } from './lst-documentos/lst-documentos.component';
import { MatPaginatorModule } from '@angular/material';
import { NavBarComponent } from './nav-bar/nav-bar.component';
import { FooterComponent } from './footer/footer.component';
import { AgregarComponent, AltaArchivoComponent, EditarComponent, MostrarComponent } from './alta-archivo/alta-archivo.component';
import { LoginUsuarioComponent } from './login/login-usuario/login-usuario.component';
import { RegistroComponent } from './login/registro/registro.component';

@NgModule({
	declarations: [
		AppComponent,
		LoginComponent,
		LstDocumentosComponent,
		NavBarComponent,
		FooterComponent,
		AgregarComponent,
		MostrarComponent,
		EditarComponent,
		LoginUsuarioComponent,
		RegistroComponent
		
	],
	imports: [
		BrowserModule,
		AppRoutingModule,
		BrowserAnimationsModule,
		FormsModule,
		MatInputModule,
		MatCardModule,
		MatTabsModule,
		MatFormFieldModule,
		MatButtonModule,
		MatCheckboxModule,
		MatIconModule,
		MatSelectModule,
		HttpClientModule,
		MatTableModule,
		MatSortModule,
		MatPaginatorModule
		],
	providers: [],
	bootstrap: [AppComponent]
})
export class AppModule { }
