import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Descarga, ICategoria, IDocumento, MiBaul } from '../app.dominio';
import { DocumentoService } from '../services/documento.service';

@Component({
	selector: 'app-alta-archivo',
	templateUrl: './alta-archivo.component.html',
	styleUrls: ['./alta-archivo.component.css']
})
export class AltaArchivoComponent implements OnInit {
	public categorias: ICategoria[] = [];
	public file: File;

	// ################################################################################
	public archivo: IDocumento = new IDocumento();
	public todasLasCategorias: ICategoria[] = [];

	constructor(
		public documentoService: DocumentoService,
		public router: Router,
		public miBaul: MiBaul
	) { };

	async ngOnInit() { };

	async mostrarArchivo() {
		if (this.miBaul.argumento) {
			this.categorias = this.archivo.categoria
		}
	};

	isChecked(id) {
		return this.categorias.some(cat => id.id_categoria === cat.id_categoria)
	};

	sumar(categoria: ICategoria): void {
		this.categorias.push(categoria);
	};

	restar(categoria: ICategoria): void {
		this.categorias = this.categorias.filter((item) => {
			return item !== categoria
		});
	};

	customFileLabel(): string {
		return this.file ? this.file.name : "Buscar archivo";
	};

	onFileSelect(event) {
		if (event.target.files.length > 0) {
			this.file = event.target.files.item(0)
			this.archivo.titulo = this.file.name.split('.')[0]
			this.archivo.extensionArchivo = this.file.name.split('.')[1]
		}
	};

	// para las botoneras
	async descargar() { };

	public formData: FormData = new FormData();
	guardar(): void {
		var docunombre = this.file ? this.file.name.replace(/^.*[\\\/]/, '').split('.') : []

		this.formData.append('documento', JSON.stringify({
			id_documento: this.miBaul.argumento,
			titulo: docunombre[0],
			extensionArchivo: docunombre[1],
			categoria: this.categorias,
			fecha_publicacion: this.archivo.fecha_publicacion,
			propietario: this.archivo.propietario
		}));
		this.formData.append('file', this.file);
	};

	cancelar() {
		this.router.navigateByUrl('lista');
	};
}

// En virtud de que estoy muy oxidado y no me sale el callback, será herencia
export class AgregarComponent extends AltaArchivoComponent {
	async ngOnInit() {
		this.todasLasCategorias = await this.documentoService.obtenerCategorias();
		this.archivo.propietario.nombreDeUsuario = sessionStorage.getItem("usuario");
	};

	async guardar() {
		try {
			super.guardar();
			await this.documentoService.agregarDocumento(this.formData);
			alert("Archivo agregado correctamente");
			this.router.navigateByUrl('lista');
		} catch (error) {
			alert("Se produjo un error al cargar el archivo");
		}
	};
}

export class MostrarComponent extends AltaArchivoComponent {
	async ngOnInit() {
		this.archivo = await this.documentoService.obtenerDocumento(this.miBaul.argumento);
		this.mostrarArchivo()
		this.todasLasCategorias = this.archivo.categoria;
	};

	async descargar() {
		const link = document.createElement('a');
		link.setAttribute('target', '_blank');
		link.setAttribute('href', 'http://localhost:8080/Archivo/' + this.miBaul.argumento);
		link.setAttribute('download', this.archivo.titulo + '.' + this.archivo.extensionArchivo);
		document.body.appendChild(link);
		link.click();
		link.remove();
		//descarga
		var descarga = new Descarga
		descarga.nombre = this.archivo.propietario.nombreDeUsuario
		descarga.idDocumento = this.miBaul.argumento.toString()
		descarga.velocidad = parseFloat((Math.random()*(50-1)+parseInt('1')).toFixed(2))
		await this.documentoService.crearDescarga(descarga)
		this.router.navigateByUrl('lista')
	};
}

export class EditarComponent extends AltaArchivoComponent {
	async ngOnInit() {
		this.archivo = await this.documentoService.obtenerDocumento(this.miBaul.argumento);
		this.miBaul.esModificable = sessionStorage.getItem("usuario") == this.archivo.propietario.nombreDeUsuario;
		this.mostrarArchivo()
		this.todasLasCategorias = await this.documentoService.obtenerCategorias();
	};

	async guardar() {
		try {
		super.guardar();
		await this.documentoService.modificarDocumento(this.formData);
		alert("Archivo modificado correctamente");
		this.router.navigateByUrl('lista');
	} catch (error) {
		alert("Se produjo un error al modificar el archivo");
	}
	};
}