package com.unsam.bd.model.entities

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors @Entity
class Categoria {
	@Id @GeneratedValue var Long id_categoria
	@Column(nullable=false, unique = true) var String descripcion
}
