<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Todo List</title>
</head>
<body>
<div class="container">
    <h1>Todo List</h1>
    <g:link class="btn btn-primary mb-3" action="create">Create New Todo</g:link>

    <table class="table">
        <thead>
        <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Owner</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${todoList}" var="todo">
            <tr>
                <td>${todo.title}</td>
                <td>${todo.description}</td>
                <td>${todo.author?.username}</td>

                <td>
                    <g:link class="btn btn-info btn-sm" action="show" id="${todo.id}">View</g:link>
                    <g:link class="btn btn-warning btn-sm" action="edit" id="${todo.id}">Edit</g:link>
                    <g:form action="delete" id="${todo.id}" method="DELETE" style="display: inline;">
                        <input class="btn btn-danger btn-sm" type="submit" value="Delete" onclick="return confirm('Are you sure?');" />
                    </g:form>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
</body>
</html>

// grails-app/views/todo/create.gsp
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Create Todo</title>
</head>
<body>
<div class="container">
    <h1>Create Todo</h1>
    <g:form action="save" method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label>Title:</label>
            <g:textField name="title" class="form-control" required="true"/>
        </div>
        <div class="form-group">
            <label>Description:</label>
            <g:textArea name="description" class="form-control" rows="3"/>
        </div>
        <div class="form-group">
            <label>Files:</label>
            <input type="file" name="files" multiple class="form-control"/>
        </div>
        <div id="wysiwygElements">
            <div class="form-group">
                <label>WYSIWYG Content:</label>
                <g:textArea name="wysiwygContents" class="form-control wysiwyg" rows="5"/>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Create</button>
    </g:form>
</div>
</body>
</html>