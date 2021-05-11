package com.unsam.bd.web.controller

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.CrossOrigin

@Controller
@CrossOrigin("http://localhost:4200")
class FileUploadController {

//	@GetMapping("/Archivo/{id}")
//	@ResponseBody
//	def ResponseEntity<Resource> serveFile(@PathVariable long id) {
//		
//		var filename = new ContenidoController().rutaDocumento(id)
//		
//		var file = storageService.loadAsResource(filename);
//		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
//				"attachment; filename=\"" + file.getFilename() + "\"").body(file)
//	}

	@ExceptionHandler(typeof(Exception))
	def ResponseEntity<?> handleStorageFileNotFound(Exception exc) {
		return ResponseEntity.notFound().build()
	}
}