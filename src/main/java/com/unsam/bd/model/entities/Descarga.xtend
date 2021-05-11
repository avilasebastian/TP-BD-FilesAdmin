package com.unsam.bd.model.entities

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.SequenceGenerator
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors @Entity
class Descarga {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY, generator = "hibernate_generator_do")
	@SequenceGenerator(name="hibernate_generator_batchesValidatedWithBista", sequenceName = "hibernate_sequence_batchesValidatedWithBista", allocationSize=1)
	var Long id_descarga
	@Column(nullable=false) var Double velocidad_transferencia
}