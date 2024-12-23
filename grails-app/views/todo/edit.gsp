<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'todo.label', default: 'Todo')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
<div id="content" role="main">
    <div class="container">
        <section class="row">
            <a href="#edit-todo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;" /></a>
            <div class="nav" role="navigation">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label" /></a></li>
                    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                </ul>
            </div>
        </section>
        <section class="row">
            <div id="edit-todo" class="col-12 content scaffold-edit" role="main">
                <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${todo}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${todo}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                                <g:message error="${error}" />
                            </li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form resource="${todo}" method="PUT" enctype="multipart/form-data">
                    <g:hiddenField name="version" value="${todo?.version}" />
                    <fieldset class="form">
                        <legend>Edit Todo</legend>

                        <g:textField name="title" value="${todo?.title}" label="Title" required="true" />

                        <!-- Textarea for Description -->
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea name="description" id="description" rows="5">${todo?.description}</textarea>
                        </div>

                        <!-- File Upload -->
                        <div>
                            <label for="files">Upload Files:</label>
                            <input type="file" name="files" id="files" multiple />
                        </div>
                    </fieldset>
                    <fieldset class="buttons">
                        <legend>Actions</legend>
                        <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    </fieldset>
                </g:form>

            </div>
        </section>
    </div>
</div>
</body>
</html>
