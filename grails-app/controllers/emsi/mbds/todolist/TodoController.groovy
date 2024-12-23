package emsi.mbds.todolist

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_USER', 'ROLE_ADMIN'])
class TodoController {

    TodoService todoService
    UploadService uploadService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def currentUser = springSecurityService.currentUser as User
        def todos

        // Correction de la vérification du rôle
        if (springSecurityService.principal.authorities.any { it.authority == 'ROLE_ADMIN' }) {
            todos = todoService.list(params)
        } else {
            todos = TodoList.findAllByOwnerOrCollaborators(currentUser, currentUser, params)
        }

        respond todos, model:[todoCount: todos.size()]
    }

    def show(Long id) {
        def todoList = todoService.get(id)
        if (!hasAccess(todoList)) {
            forbidden()
            return
        }
        respond todoList
    }

    def create() {
        respond new Todo(params)
    }

    def save(Todo todoList) {
        if (todoList == null) {
            notFound()
            return
        }

        todoList.owner = springSecurityService.currentUser as User

        try {
            todoService.save(todoList)

            // Gestion des éléments de type fichier
            def files = request.getFiles('files')
            files.each { MultipartFile file ->
                if (!file.empty) {
                    uploadService.uploadFile(file, todoList)
                }
            }

            // Gestion des éléments WYSIWYG
            if (params.wysiwygContents) {
                params.list('wysiwygContents').eachWithIndex { content, index ->
                    if (content) {
                        def element = new WysiwygElement(
                                content: content,
                                position: index + 1,
                                todoList: todoList
                        )
                        element.save(flush: true)
                    }
                }
            }

        } catch (ValidationException e) {
            respond todoList.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'todo.label', default: 'Todo'), todoList.id])
                redirect todoList
            }
            '*' { respond todoList, [status: CREATED] }
        }
    }

    def edit(Long id) {
        def todoList = todoService.get(id)
        if (!hasAccess(todoList)) {
            forbidden()
            return
        }
        respond todoList
    }

    def update(Todo todoList) {
        if (todoList == null) {
            notFound()
            return
        }

        if (!hasAccess(todoList)) {
            forbidden()
            return
        }

        try {
            todoService.save(todoList)

            // Gestion des nouveaux fichiers
            def files = request.getMultiFileMap()?.get('files')
            files.each { MultipartFile file ->
                if (!file.empty) {
                    uploadService.uploadFile(file, todoList)
                }
            }

            // Mise à jour des éléments WYSIWYG existants
            if (params.wysiwygContents) {
                todoList.elements.findAll { it instanceof WysiwygElement }.each { it.delete() }
                params.list('wysiwygContents').eachWithIndex { content, index ->
                    if (content) {
                        def element = new WysiwygElement(
                                content: content,
                                position: index + 1,
                                todoList: todoList
                        )
                        element.save(flush: true)
                    }
                }
            }

        } catch (ValidationException e) {
            respond todoList.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'todo.label', default: 'Todo'), todoList.id])
                redirect todoList
            }
            '*'{ respond todoList, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        def todoList = todoService.get(id)
        if (!hasAccess(todoList)) {
            forbidden()
            return
        }

        todoService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'todo.label', default: 'Todo'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'todo.label', default: 'Todo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    protected void forbidden() {
        render status: FORBIDDEN
    }

    private boolean hasAccess(Todo todoList) {
        if (!todoList) return false

        def currentUser = springSecurityService.currentUser as User
        return springSecurityService.principal.authorities.any { it.authority == 'ROLE_ADMIN' } ||
                todoList.owner == currentUser ||
                todoList.collaborators.contains(currentUser)
    }
}
