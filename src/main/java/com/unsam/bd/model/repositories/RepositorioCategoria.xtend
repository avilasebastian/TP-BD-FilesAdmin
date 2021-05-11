package com.unsam.bd.model.repositories

import com.unsam.bd.model.entities.Categoria
import org.springframework.data.repository.CrudRepository
import org.springframework.data.jpa.repository.Query
import java.util.List

interface RepositorioCategoria extends CrudRepository<Categoria, Long> {
	
	@Query(value = "SELECT categoria from Categoria categoria")
	def List<Categoria> obtenerTodasLasCategorias()
	
}