package com.unsam.bd.model.repositories

import com.unsam.bd.model.entities.Usuario
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param

interface RepositorioUsuario extends CrudRepository<Usuario, String> {
	@Query(value='
		SELECT `nombre_de_usuario` FROM `db_grupo2`. `usuario`
			WHERE
				`db_grupo2`. `usuario`.`nombre_de_usuario` = :usuario_ AND
				`db_grupo2`. `usuario`.`password` = :password_ ;
		', nativeQuery = true
	)
	def Iterable<Integer> loginUsuario(
		@Param("usuario_") String usuario_,
		@Param("password_") String password_
	)

	@Query(value='
		INSERT INTO `db_grupo2`.`usuario`
		(`nombre_de_usuario`, `apellido`,`fecha_nacimiento`, `nombre`, `password`) VALUES
		(  :nombreDeUsuario , :apellido , :fechaNacimiento , :nombre , :password );
		', nativeQuery = true
	)
	def void guardarUsuario (
		@Param("nombreDeUsuario") String nombreDeUsuario,
		@Param("password") String password,
		@Param("nombre")  String nombre,
		@Param("apellido")  String apellido,
		@Param("fechaNacimiento")  String fechaNacimiento
	) 
}
