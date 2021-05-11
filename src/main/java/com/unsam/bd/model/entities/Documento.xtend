package com.unsam.bd.model.entities

import java.time.LocalDate
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.JoinTable
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.GenerationType
import javax.persistence.SequenceGenerator
import javax.persistence.ManyToOne

@Accessors @Entity
class Documento {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY, generator = "hibernate_generator_do")
	@SequenceGenerator(name="hibernate_generator_batchesValidatedWithBista", sequenceName = "hibernate_sequence_batchesValidatedWithBista", allocationSize=1)
	var Long id_documento
	@Column(nullable=false) var String titulo
	@Column(nullable=false) var LocalDate fecha_publicacion
	@Column(nullable=false) var String extensionArchivo
	@Column(nullable=false, columnDefinition = "boolean default true") var Boolean disponible

	@ManyToMany @JoinTable
	var Set<Categoria> categoria = newHashSet

	@OneToMany @JoinColumn
	var Set<Descarga> descargas = newHashSet;
	
	def int getCantidadDescargas() {
		descargas.length
	}
	
	@ManyToOne @JoinColumn
	var Usuario propietario
}
