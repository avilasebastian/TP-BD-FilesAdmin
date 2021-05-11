package com.unsam.bd.model.repositories

import org.springframework.data.repository.CrudRepository
import com.unsam.bd.model.entities.Usuario
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.transaction.annotation.Transactional
import org.springframework.data.jpa.repository.Modifying

interface RepositorioUsuario extends CrudRepository<Usuario, String> {
	def Boolean existsByNombreDeUsuarioAndPassword(String nombreDeUsuario, String password)

	/**
	 * OJO: en INTO se ingresan los nombres de las columnas en la tabla
	 * 		y VALUES se ingresan los atributos del objeto 
	 */
	@Transactional
	@Modifying(clearAutomatically=true, flushAutomatically=true)
	@Query(value="INSERT INTO usuario 
					(nombre_de_usuario, apellido, fecha_de_nacimiento, nombre, password) 
							VALUES 
					( :#{#nuevoUsuario.nombreDeUsuario}
					, :#{#nuevoUsuario.apellido}
					, :#{#nuevoUsuario.fechaDeNacimiento}
					, :#{#nuevoUsuario.nombre}
					, :#{#nuevoUsuario.password} )", nativeQuery=true)
	def void registrarUsuario(@Param("nuevoUsuario") Usuario nuevoUsuario)

}
