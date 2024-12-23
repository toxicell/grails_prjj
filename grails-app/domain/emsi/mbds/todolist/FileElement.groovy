package emsi.mbds.todolist

class FileElement extends Element {

    String fileName
    String filePath
    String contentType
    Long fileSize

    static constraints = {
        fileName blank: false
        filePath blank: false
        contentType blank: false
        fileSize nullable: false
    }
}
