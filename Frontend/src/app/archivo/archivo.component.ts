import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Router } from '@angular/router';
import { DocumentoService } from '../services/documento.service';

@Component({
  selector: 'app-archivo',
  templateUrl: './archivo.component.html',
  styleUrls: ['./archivo.component.css']
})
export class ArchivoComponent implements OnInit {
  archivo: any  = {}
  nroarchivo: string

  constructor(private route: ActivatedRoute, private documentoService: DocumentoService, private router: Router) {    
    this.route
      .queryParams
      .subscribe(params => { 
        this.nroarchivo = params['archivo'];
      });
  }

  async ngOnInit() {
    console.log(this.nroarchivo)
    this.archivo = await this.documentoService.obtenerDocumento(this.nroarchivo);
  }

  volver(){
    this.router.navigateByUrl('lista')
  }
}
