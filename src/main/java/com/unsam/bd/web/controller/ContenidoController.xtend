package com.unsam.bd.web.controller

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import java.util.List
import org.springframework.beans.factory.annotation.Autowired
import java.util.Arrays
import com.unsam.bd.model.repositories.RepositorioDocumento
import com.unsam.bd.model.entities.Documento
import com.unsam.bd.model.repositories.RepositorioCategoria
import org.springframework.data.jpa.repository.EntityGraph
import com.unsam.bd.model.entities.Categoria
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.http.MediaType
import org.springframework.data.domain.PageRequest
import java.util.ArrayList
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.http.HttpStatus
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.bind.annotation.RequestParam
import com.unsam.bd.model.repositories.StorageService
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule
import com.fasterxml.jackson.databind.DeserializationFeature
import org.springframework.http.ResponseEntity
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders
import org.springframework.web.bind.annotation.PutMapping
import javax.transaction.Transactional
import java.nio.file.NoSuchFileException
import com.unsam.bd.model.entities.StorageException
import javassist.NotFoundException

@Controller
@CrossOrigin("http://localhost:4200")
class ContenidoController {

	@Autowired
	RepositorioDocumento repositorioDocumento

	@Autowired
	RepositorioCategoria repositorioCategoria

	@Autowired
	StorageService storageService;

	@GetMapping(path="/documentos", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	def List<Documento> documentos() {
		Arrays.asList(repositorioDocumento.obtenerTodosLosDocumentos)
	}

	@GetMapping(path="/extensiones", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	def List<String> obtenerExtensiones() {
		repositorioDocumento.obtenerExtensiones
	}

	@EntityGraph(attributePaths="descripcion")
	@GetMapping(path="/categorias", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	def List<Categoria> obtenerCategorias() {
		Arrays.asList(repositorioCategoria.obtenerTodasLasCategorias)
	}

	@PostMapping(path="/buscarTitulo", consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.
		APPLICATION_JSON_VALUE)
	@ResponseBody
	def Documento buscarTitulo(@RequestBody String tituloSolicitado) {
		println(tituloSolicitado)
		repositorioDocumento.findByTitulo(tituloSolicitado)
	}
	
	@GetMapping("/Archivo/{id}")
	@ResponseBody
	def ResponseEntity<Resource> serveFile(@PathVariable long id) {
		
		var doc = repositorioDocumento.buscarDocumentoPorId(id).get		
		var filename = doc.id_documento.toString
		
		var file = storageService.loadAsResource(filename);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
				"attachment; filename=\"" + doc.titulo + "." + doc.extensionArchivo + "\"").body(file)
	}

	/*
	 * @RequestMapping(method = RequestMethod.PUT, path = "/{code}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	 * @ResponseBody
	 * @ResponseStatus(code = HttpStatus.ACCEPTED)
	 * @Transactional(readOnly = false)
	 * public Country update(@PathVariable("code") String code, @Valid @RequestBody CountryRequest request,
	 * 		BindingResult errors) {
	 */
	@GetMapping(path="/ver/{id_contenido}")
	@ResponseBody
	def Documento verDocumento(@PathVariable("id_contenido") Long idContenido) {
		println(idContenido)
		repositorioDocumento.buscarDocumentoPorId(idContenido).get
	}
	
	@Transactional
	@PostMapping(path="/agregarDocumento", consumes=MediaType.MULTIPART_FORM_DATA_VALUE) @ResponseBody
	@ResponseStatus(code=HttpStatus.CREATED)
	def void agregarDocumento(@RequestParam("file") MultipartFile file, @RequestParam("documento") String documento) {
		try {
		var objectMapper = new com.fasterxml.jackson.databind.ObjectMapper() // Mapea un String con formato Json en un objeto 
		objectMapper.registerModule(new JavaTimeModule()) // Para las fechas
		objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false) // No setea en el objeto las  propiedades faltantes en el json
		var doc = repositorioDocumento.guardarDocumento(objectMapper.readValue(documento, typeof(Documento)))
		storageService.store(file, doc);
		} catch(StorageException e) {
			throw new NotFoundException("Se produjo un error al cargar el archivo")
		}
	}

	@Transactional
	@PostMapping(path="/modificarDocumento", consumes=MediaType.MULTIPART_FORM_DATA_VALUE) @ResponseBody
	@ResponseStatus(code=HttpStatus.CREATED)
	def void modificarDocumento(@RequestParam("file") MultipartFile file, @RequestParam("documento") String documento) {
		try {
		var objectMapper = new com.fasterxml.jackson.databind.ObjectMapper() // Mapea un String con formato Json en un objeto 
		objectMapper.registerModule(new JavaTimeModule()) // Para las fechas
		objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false) // No setea en el objeto las  propiedades faltantes en el json
		var doc = objectMapper.readValue(documento, typeof(Documento))
		repositorioDocumento.modificarDocumento(doc)
		println("Documento id " + doc.id_documento)
//		if (!file.isEmpty()) {
			storageService.store(file, doc);
//		}
		} catch(StorageException e) {
			throw new NotFoundException("Se produjo un error al modificar el archivo")
		}
	}

//	@PostMapping(path="/editarDocumento", consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE) @ResponseBody
//	@ResponseStatus(code = HttpStatus.ACCEPTED)
//	def void editarDocumento(@RequestBody Documento dn) {
//		repositorioDocumento.guardarDocumento(dn.titulo, dn.fecha_publicacion.toString , dn.extensionArchivo)
//	}
//	@DeleteMapping(path="/eliminarDocumento/{idDocumento}")
//	@ResponseStatus(code=HttpStatus.ACCEPTED)
//	def eliminarDocumento(@PathVariable("idDocumento") Long id) {
//		repositorioDocumento.deleteById(id)
//	}

	//TODO Baja logica Controller
	@PutMapping(path="/eliminarDocumento/{idDocumento}")
	@ResponseStatus(code=HttpStatus.ACCEPTED)
	def void eliminarDocumento(@PathVariable("idDocumento") long id) {
		repositorioDocumento.bajaDocumento(id)
	}
	//TODO Crear descarga

//	@PostMapping(path="/crearDescarga", consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.
//		APPLICATION_JSON_VALUE)
////	def void agregarDocumento(@RequestParam("file") MultipartFile file, @RequestParam("documento") String documento)
//	def void crearDescarga(@RequestParam("documento") Double velocidad, @RequestParam("nombre") String nombre, @RequestParam("idDocumento") long idDocumento){
//		repositorioDocumento.crearDescarga(velocidad, nombre, idDocumento)
//	}

	@PutMapping(path="/crearDescarga/{velocidad}/{nombre}/{idDocumento}")	
	@ResponseStatus(code=HttpStatus.CREATED)
	def void crearDescarga(@PathVariable("velocidad") Double velocidad, @PathVariable("nombre") String nombre, @PathVariable("idDocumento") long idDocumento) {
		repositorioDocumento.crearDescarga(velocidad, nombre, idDocumento)
	}

	@GetMapping(path="/tbldocumentos/{pag}/{cant}")
	@ResponseBody
	def List<Documento> findPaginated(@PathVariable("pag") int pag, @PathVariable("cant") int cant) {
		var resultPage = repositorioDocumento.findAll(PageRequest.of(pag, cant))
		if (pag > resultPage.getTotalPages()) {
			return new ArrayList<Documento>();
		}

		return resultPage.getContent();
	}
	


}
