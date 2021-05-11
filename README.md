# TP Integrador de Bases de Datos - Grupo 2

### Iindice
* [Introduccion](https://github.com/joniim23/BD_GRUPO2_2020_UNSAM_TP_INTEGRADOR/tree/master#introducci%C3%B3n)
* [Integrantes del equipo](https://github.com/joniim23/BD_GRUPO2_2020_UNSAM_TP_INTEGRADOR/tree/master#integrantes-del-equipo--%EF%B8%8F)
* [Descripción del proyecto](https://github.com/joniim23/BD_GRUPO2_2020_UNSAM_TP_INTEGRADOR/tree/master#descripci%C3%B3n-del-proyecto-)
* [Requerimientos del enunciado](https://github.com/joniim23/BD_GRUPO2_2020_UNSAM_TP_INTEGRADOR/tree/master#requerimientos-del-enunciado-)
* [Herramientas Utilizadas](https://github.com/joniim23/BD_GRUPO2_2020_UNSAM_TP_INTEGRADOR/tree/master#herramientas-utilizadas-%EF%B8%8F)
* [Diagrama de Entidad Relación](https://github.com/joniim23/BD_GRUPO2_2020_UNSAM_TP_INTEGRADOR/tree/master#diagrama-de-entidad-relaci%C3%B3n)
* [Capturas de pantalla](https://github.com/joniim23/BD_GRUPO2_2020_UNSAM_TP_INTEGRADOR/tree/master#capturas-de-pantalla-)

### Introducción

_Este es un proyecto para un trabajo practico integrador de la materia bases de datos de la [Universidad Nacional de San Martin](http://www.unsam.edu.ar/).<br />
El objetivo es la construcción de un softwhare que implemente algunas de las funcionalidades de los [requerimientos detallados en el enunciado del TP integrador ***"implementación base de datos"***](https://github.com/joniim23/BD_GRUPO2_2020_UNSAM_TP_INTEGRADOR/tree/master#requerimientos-del-enunciado-)._

### Integrantes del equipo  ✒️

* **Sebastián Avila** - [avilatuan@gmail.com](#avilatuan@gmail.com)
* **Rafael José Calderón** - [rafael_jose_calderon@hotmail.com](#rafael_jose_calderon@hotmail.com)
* **Mauricio Carunchio** - [mauricio_carunchio@hotmail.com](#mauricio_carunchio@hotmail.com)
* **Jonathan Mansilla** - [jonathan.mansi@gmail.com](#jonathan.mansi@gmail.com)
* **Marcos David Benitez** - [mbenitez82@gmail.com](#mbenitez82@gmail.com)




### Descripción del proyecto 🚀

_Se trata de un sistema de archivos que permite almacenar documentos digitales en varios formatos (xls, word, pdf, etc.) en un repositorio y,
por otra parte, la información de cada documento será persistida en una base de datos.<br />
Los usuarios registrados podrán realizar altas, bajas, consultas y modificaciones a través de la capa de presentación que además permitirá subir y descargar dichos archivos.<br />
Para facilitar la búsqueda de documentos la aplicación cuenta con filtros de búsqueda por título, por categoría y por extensión.<br/>
En pocas palabras un usuario del sistema va a ser capaz de realizar las siguientes acciones:_
1. Loguearse
2. Ver la lista completa de documentos
3. Filtrar los documentos por titulo, categoria y/o extensión
4. Agregar nuevo documento
5. Editar un documento existente
6. Eliminar un documento existente
7. Consultar la información de un documento especifico
8. Subir y descargar un archivo del repositorio

###  Requerimientos del enunciado 📋

```
Se desea construir un software para administrar contenidos sobre una plataforma web:
Los contenidos que se van a publicar y que luego podrán ser accedidos desde internet pueden ser de tres tipos: archivo de video, de música o documentos (tipo Word, pdf,Excel, powerpoint, etc.).
De cada contenido a colocar en la plataforma web se registrará un id único, un título (representativo del contenido), la fecha en que se publica en la plataforma y la extensión del archivo (.word, .xls, .pdf, .wav, .mp5, etc.).
Los contenidos se clasifican en categorías, por ejemplo, si es de música, de deporte, de investigación, de economía, noticia, entretenimiento, salud, etc.
Sobre los contenidos de música y documentos se pueden realizar acciones de descarga (y no visualización online).
Los contenidos de video solo pueden ser reproducidos (no pueden ser descargados, solo vistos online).
Cada contenido puede corresponder a más de una categoría y viceversa.
Sobre cada contenido, quién lo descarga o visualiza, puede colocar comentarios para que otras personas luego vean.
Sobre la reproducción de videos se registra un id único de reproducción, la fecha de inicio de la reproducción, la hora en que se inicia, la fecha fin de la reproducción y la hora de fin. También el OS utilizado.
Sobre una descarga, las cuales aplican a contenidos de música y de documentos, requiere de un usuario logueado en la plataforma. No pueden realizarse de manera
anónima (como si la reproducción de videos). Entonces, de la descarga de un contenido se registra la velocidad de transferencia y el usuario que la realiza. Tb un id único de descarga.
En el caso de usuarios registrados de la plataforma (no los anónimos) de los mismos se ingresa un identificador único, su apellido, nombre, fecha de nacimiento y password.
Un contenido puede tener ninguno, uno o varios comentarios. Un comentario solo corresponde a un contenido. De cada comentario se registra un id único, un título
breve y la descripción detallada. También un apodo que elige el comentarista.
Cada comentario, a su vez, puede o no tener réplicas realizadas por otras personas.
Inclusive una réplica puede tener luego, otras réplicas de respuesta asociadas. De cada réplica se registra su id, un detalle y un apodo para la persona que realiza la réplica.
Para algunas descargas de música o archivos realizados por algunos usuarios, una vez terminadas las mismas se les ofrece contestar una encuesta sencilla sobre la
experiencia de descarga. En el caso que acepten responder la misma se registra un id único de la misma, el puntaje global de la experiencia de descarga, un resumen de lo positivo y un resumen de lo negativo de la plataforma y de la descarga.
Los comentarios y sus réplicas son anónimos, no requieren un usuario logueado en la plataforma de contenidos para que puedan ser ingresados.
```

### Herramientas Utilizadas 🛠️

* **[MySQL](https://www.mysql.com/)** - Para la base de datos.-
* **[XTEND](https://www.eclipse.org/xtend/index.html)** - Para la codificación de las clases del modelo y los controladores.-
* **[Maven](https://maven.apache.org/)** - Como manejador de dependencias.-
* **[Spring](https://spring.io/)** - Para el mapeo de los objetos con la base de datos.-
* **[Angular](https://angular.io/)** - Para el desarrollo de la vista web.-

### Diagrama de Entidad Relación
![DER](https://github.com/avilasebastian/TP-BD-FilesAdmin/blob/master/Docs/DER.png)<br />

### Capturas de pantalla 🔧
- ***Login y Registro de Usuario***<br />
![Login y registro](https://github.com/avilasebastian/TP-BD-FilesAdmin/blob/master/Docs/Login.png)<br />


### Expresión de Gratitud :+1: 
* Gracias por tanto!!! perdon por tan poco 🤓.
