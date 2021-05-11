package com.unsam.bd.model.repositories

import com.unsam.bd.model.entities.Documento
import java.util.List
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param
import java.util.Optional
import javax.transaction.Transactional
import org.springframework.data.jpa.repository.Modifying

interface RepositorioDocumento extends PagingAndSortingRepository<Documento, Long> {
	@Query(value="SELECT distinct(extensionArchivo) from Documento documento")
	def List<String> obtenerExtensiones()

	@Query(value="SELECT documento from Documento documento where documento.titulo = :tituloSolicitado")
	def Documento findByTitulo(@Param("tituloSolicitado") String tituloSolicitado)

	@Query(value="SELECT documento from Documento documento where documento.disponible = 1")
	def List<Documento> obtenerTodosLosDocumentos()

	@Query(value="SELECT documento from Documento documento where documento.id = :idDocumento")
	def Optional<Documento> buscarDocumentoPorId(@Param("idDocumento") Long idDocumento)

	@Transactional(rollbackOn=typeof(Exception))
	def Documento guardarDocumento(@Param("documento") Documento documento){
		saveDocumento(documento)
		documento.id_documento = ultimoId
		documento.categoria.forEach[cat|
			 guardarCategoriaDocumento(documento.id_documento, cat.id_categoria)]
		documento
		}

	@Transactional(rollbackOn=typeof(Exception))
	def Documento modificarDocumento(@Param("documento") Documento documento){

		updateDocumento(documento)

		borrarCategoriasDoc(documento.id_documento)
		documento.categoria.forEach[cat|
			 guardarCategoriaDocumento(documento.id_documento, cat.id_categoria)]
		documento
		}
		
	@Query(value="SELECT last_insert_id();", nativeQuery=true)
	def long ultimoId()
	
	@Transactional
	@Modifying(clearAutomatically=true, flushAutomatically=true)
	@Query(value="INSERT INTO documento_categoria (documento_id_documento, categoria_id_categoria) VALUES (:documento, :categoria)", nativeQuery=true)					             
	def void guardarCategoriaDocumento(@Param("documento") long idDocumento, @Param("categoria") long idCategoria)
		
	@Transactional
	@Modifying(clearAutomatically=true, flushAutomatically=true)
	@Query(value="INSERT INTO documento 
					(titulo, fecha_publicacion, extension_archivo, propietario_nombre_de_usuario) 
				  VALUES 
					( :#{#newDoc.titulo}
					, :#{#newDoc.fecha_publicacion}
					, :#{#newDoc.extensionArchivo}
					, :#{#newDoc.propietario} )", nativeQuery=true)
	def void saveDocumento(@Param("newDoc") Documento nuevoDocumento)
	
	@Transactional	
	@Modifying(clearAutomatically=true, flushAutomatically=true)
	@Query(value="UPDATE documento set disponible = 0 where id_documento = :id_doc", nativeQuery=true)
	def void bajaDocumento(@Param("id_doc") long idDocumento)
	
	@Transactional	
	@Modifying(clearAutomatically=true, flushAutomatically=true)
	@Query(value="UPDATE documento SET titulo = :#{#newDoc.titulo},
			fecha_publicacion = :#{#newDoc.fecha_publicacion},
			extension_archivo = :#{#newDoc.extensionArchivo},
			propietario_nombre_de_usuario = :#{#newDoc.propietario},
			disponible = 1 WHERE id_documento = :#{#newDoc.id_documento}", nativeQuery=true)
	def void updateDocumento(@Param("newDoc") Documento nuevoDocumento)
	
	@Transactional	
	@Modifying(clearAutomatically=true, flushAutomatically=true)
	@Query(value="DELETE FROM documento_categoria WHERE documento_id_documento = :idDocumento", nativeQuery=true)
	def void borrarCategoriasDoc(@Param("idDocumento") long idDocumento)	
	
	@Transactional	
	@Modifying(clearAutomatically=true, flushAutomatically=true)
	@Query(value="INSERT INTO descarga (velocidad_transferencia, descargas_nombre_de_usuario, descargas_id_documento) 
								VALUE ( :velocidad , :nombreDeUsuario , :idDocumento )", nativeQuery=true)
	def void crearDescarga(@Param("velocidad") Double velocidad,@Param("nombreDeUsuario") String nombreDeUsuario,@Param("idDocumento") long idDocumento)

/*@Query(value = "INSERT INTO `db_grupo2`.`contenido`
 * (`titulo`, `fecha_publicacion`, `extension_archivo`) VALUES", nativeQuery = true)
 * def void guardarDocumento(@Param("titulo") String titulo
 * 	,@Param("fecha_publicacion") String fecha_publicacion
 ,@Param("extension_archivo") String extensionArchivo)*/
}
