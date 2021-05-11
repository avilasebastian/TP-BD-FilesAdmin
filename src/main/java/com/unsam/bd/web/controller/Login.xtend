package com.unsam.bd.web.controller

import com.unsam.bd.model.entities.Usuario
import com.unsam.bd.model.repositories.RepositorioUsuario
import java.time.format.DateTimeParseException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.ResponseStatus

@Controller
@CrossOrigin("http://localhost:4200")
class Login {
	@Autowired
	var RepositorioUsuario repositorioUsuario

	@PostMapping(path="/login") @ResponseBody
	def Boolean validarUsuario(@RequestBody Usuario request) {
		repositorioUsuario.existsByNombreDeUsuarioAndPassword(
			request.nombreDeUsuario,
			request.password
		)
	}

	@PostMapping(path="/registrarUsuario", consumes=MediaType.APPLICATION_JSON_VALUE)
	@ResponseStatus(code=HttpStatus.CREATED)@ResponseBody
	def void agregarUsuario(@RequestBody Usuario request) {
		try 
			repositorioUsuario.registrarUsuario(request)
		catch (DateTimeParseException e)
			throw new Exception("Error al ingresar usuario: " + e.message)
	}
}