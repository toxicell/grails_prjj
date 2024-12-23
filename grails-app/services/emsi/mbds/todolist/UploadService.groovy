package emsi.mbds.todolist

import grails.gorm.transactions.Transactional
import org.springframework.web.multipart.MultipartFile

@Transactional
class UploadService {

    def grailsApplication

    FileElement uploadFile(MultipartFile file, Todo todoList) {
        if (file.empty) {
            return null
        }

        // Créer le répertoire d'upload s'il n'existe pas
        def uploadDir = new File("${grailsApplication.config.uploadFolder}/todolist-${todoList.id}")
        if (!uploadDir.exists()) {
            uploadDir.mkdirs()
        }

        // Générer un nom de fichier unique
        def fileName = "${System.currentTimeMillis()}-${file.originalFilename}"
        def filePath = new File(uploadDir, fileName)

        // Sauvegarder le fichier
        file.transferTo(filePath)

        // Créer l'élément FileElement
        def fileElement = new FileElement(
                fileName: file.originalFilename,
                filePath: filePath.absolutePath,
                contentType: file.contentType,
                fileSize: file.size,
                position: (todoList.elements?.size() ?: 0) + 1,
                todoList: todoList
        )

        fileElement.save(flush: true)
        return fileElement
    }
}

