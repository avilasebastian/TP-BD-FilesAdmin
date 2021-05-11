package com.unsam.bd.model.repositories

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.Path;
import java.util.stream.Stream;
import com.unsam.bd.model.entities.Documento

interface StorageService {

	def void init();

	def void store(MultipartFile file, Documento doc)

	def Stream<Path> loadAll()

	def Path load(String filename)

	def Resource loadAsResource(String filename)

	def void deleteAll()
}