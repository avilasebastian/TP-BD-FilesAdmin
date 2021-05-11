package com.unsam.bd.model.entities

import com.unsam.bd.model.repositories.StorageService
import org.springframework.stereotype.Service
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.stream.Stream;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.Files
import java.io.IOException
import java.net.MalformedURLException
import org.springframework.beans.factory.annotation.Value

@Service
class FileSystemStorage implements StorageService {
	
	@Value("${app.upload.dir}")
	Path rootLocation

	override store(MultipartFile archivo, Documento doc) {
		try {
			var destinationFile = rootLocation.resolve(Paths.get(doc.id_documento.toString)).normalize().toAbsolutePath()
			var inputStream = archivo.inputStream

			java.nio.file.Files.copy(inputStream, destinationFile, StandardCopyOption.REPLACE_EXISTING)
		}catch (IOException e) {
			println(e)
			throw new StorageException("No se pudo guaradar el archivo, error inesperado.\n", e)
		}
	}

	override Stream<Path> loadAll() {
		try {
			java.nio.file.Files.walk(rootLocation, 1)
		}
		catch (IOException e) {
			throw new StorageException("No se pudieron leer los archivos almacenados", e);
		}
	}

	override Path load(String filename) {
		return rootLocation.resolve(filename);
	}

	override Resource loadAsResource(String filename) {
		try {
			var file = load(filename);
			var resource = new UrlResource(file.toUri())
			if (resource.exists() || resource.isReadable()) {
				resource;
			} else {
				throw new StorageFileNotFoundException("No se pudo leer el archivo: " + filename)
			}
		} catch (MalformedURLException e) {
			throw new StorageFileNotFoundException("No se pudo leer el archivo: " + filename, e)
		}
	}

	override void deleteAll() {
		FileSystemUtils.deleteRecursively(rootLocation.toFile())
	}

	override init() {
		try {
			Files.createDirectories(rootLocation);
		} catch (IOException e) {
			throw new StorageException("No se pudo guaradar el archivo", e)
		}
	}
}

class StorageException extends RuntimeException {

	new(String message) {
		super(message);
	}

	new(String message, Throwable cause) {
		super(message, cause);
	}
}

class StorageFileNotFoundException extends StorageException {

	new(String message) {
		super(message)
	}

	new(String message, Throwable cause) {
		super(message, cause);
	}
	
}