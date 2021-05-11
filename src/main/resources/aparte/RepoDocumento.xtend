package com.unsam.bd.model.repositories

import com.unsam.bd.model.entities.Documento
import java.util.List
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext
import org.springframework.stereotype.Repository

@Repository
class RepoDocumento {
	@PersistenceContext
	var EntityManager entityManager

	def List<Documento> listar() {
		entityManager.createNativeQuery(
			''' SELECT * FROM `db_grupo2`.`documento`
				INNER JOIN `db_grupo2`.`contenido`
				ON `db_grupo2`.`documento`.`id_contenido` = `db_grupo2`.`contenido`.`id_contenido`''',
			Documento
		).resultList
	}

	def void guardar(Documento documento) {
		println(documento)
		entityManager.createNativeQuery(
			''' INSERT `db_grupo2`.`contenido`
				(          `titulo`,           `fecha_publicacion`,            `extension_archivo`) VALUES
				(«documento.titulo», «documento.fecha_publicacion»,  «documento.extension_archivo»);'''
		)
	}

	def void actualizar(Documento documento) {
		entityManager => [
			transaction.begin
			merge(documento)
			transaction.commit
		]
	}

	def void eliminar(Long id) {
		entityManager => [
			transaction.begin
			remove(it.find(Documento, id))
			transaction.commit
		]
	}
}