package com.unsam.bd.model.entities

import java.time.LocalDate
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors @Entity
class Usuario {
	@Id var String nombreDeUsuario
	@Column(nullable=false) var String password
	@Column(nullable=false) var String nombre
	@Column(nullable=false) var String apellido
	@Column(nullable=false) var LocalDate fechaDeNacimiento
	
	@OneToMany @JoinColumn
	var Set<Descarga> descargas = newHashSet;
}