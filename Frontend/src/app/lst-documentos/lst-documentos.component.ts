import { Component, OnInit, ViewChild } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { ICategoria, IDocumento, MiBaul } from '../app.dominio';
import { DocumentoService } from '../services/documento.service';
import { MatSort } from '@angular/material';


@Component({
	selector: 'app-lst-documentos',
	templateUrl: './lst-documentos.component.html',
	styleUrls: ['./lst-documentos.component.css']
})
export class LstDocumentosComponent implements OnInit {

	categorias: ICategoria[]
	extensiones: String[]
	displayedColumns: string[] = ['titulo', 'extensionArchivo', 'cantidadDescargas', 'ver', 'modificar', 'eliminar']
	dataSource: MatTableDataSource<IDocumento>
	docx: IDocumento[]
	extension: string
	categoria: string

	constructor(
		private route: ActivatedRoute,
		private documentoService: DocumentoService,
		private router: Router,
		private miBaul: MiBaul
	) { }

	async ngOnInit() {
		this.categorias = await this.documentoService.obtenerCategorias();
		this.extensiones = await this.documentoService.obtenerExtensiones();
		this.obtenerLista();
	}

	async obtenerLista() {
		this.docx = await this.documentoService.obtenerListaDocumentos();
		this.docx.forEach(x => x.activo = true)
		this.dataSource = new MatTableDataSource<IDocumento>(this.docx)
		this.dataSource.paginator = this.paginator;
		this.dataSource.sort = this.sort;
	}

	@ViewChild(MatPaginator, { static: true }) paginator: MatPaginator;

	applyFilter(form) {
		var docsfilter: IDocumento[]

		docsfilter = this.docx.filter(x => x.activo &&
			this.filtrarDocumento(x, form.value.titulo, form.value.extension, form.value.categoria))

		this.dataSource = new MatTableDataSource<IDocumento>(docsfilter);
		this.dataSource.paginator = this.paginator;
		this.dataSource.paginator.firstPage();
		this.dataSource.sort = this.sort;
	}

	filtrarDocumento(row: IDocumento, titulo: string, extension: string, categoria: string) {
		var rta = true;
		if (titulo) {
			rta = rta && row.titulo.toLocaleLowerCase().includes(titulo.toLocaleLowerCase())
		}
		if (extension) {
			rta = rta && row.extensionArchivo.toLocaleLowerCase() == extension.toLocaleLowerCase()
		}

		if (categoria) {
			var rtacategoria = row.categoria.filter(x => x.descripcion == categoria)

			rta = rta && rtacategoria.length > 0
		}

		return rta
	}

	onClickLimpiar(form) {
		form.controls.extension.setValue(null)
		form.controls.titulo.setValue(null)
		form.controls.categoria.setValue(null)
		this.applyFilter(form)
	}

	agregar() {
		this.miBaul.setComponente();
		this.router.navigateByUrl('agregar');
	}

	btnver(id, event) {
		this.miBaul.setComponente(id.id_documento, false);
		this.router.navigateByUrl('mostrar');
	}	

	btnmodificar(id, event) {
		this.miBaul.setComponente(id.id_documento);
		this.router.navigateByUrl('editar');
	}
	@ViewChild(MatSort, { static: true }) sort: MatSort;

	async btneliminar(id, event) {
		await this.documentoService.eliminarDocumento(id.id_documento)
		this.obtenerLista();
	}
}

