import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AgregarComponent, AltaArchivoComponent, EditarComponent, MostrarComponent } from './alta-archivo/alta-archivo.component';
import { LoginComponent } from './login/login.component';
import { LstDocumentosComponent } from './lst-documentos/lst-documentos.component';


const routes: Routes = [
  { path:   'login', component:              LoginComponent },
  { path:   'lista', component:      LstDocumentosComponent },
  { path: 'agregar', component:        AgregarComponent },
  { path: 'mostrar', component:        MostrarComponent },
  { path:  'editar', component:        EditarComponent },
  { path:        '', redirectTo: 'login', pathMatch: 'full' },
  { path:      '**', redirectTo: 'login', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
