<!doctype html>
<html>
<head>
    <%@ page import="grails.plugin.springsecurity.SecurityTagLib" %>
    <meta name="layout" content="main"/>
    <title><g:layoutTitle default="Todo App"/></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.2.0/css/adminlte.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <g:layoutHead/>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
            </li>
        </ul>
    </nav>

    <!-- Main Sidebar -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <!-- Brand Logo -->
        <a href="${createLink(uri: '/')}" class="brand-link">
            <span class="brand-text font-weight-light">Todo App</span>
        </a>

        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column">
                    <li class="nav-item">
                        <a href="${createLink(controller: 'todoList')}" class="nav-link">
                            <i class="nav-icon fas fa-list"></i>
                            <p>Todo Lists</p>
                        </a>
                    </li>
                    <g:if test="${sec.access(expression: "hasRole('ROLE_ADMIN')")}">
                        <li class="nav-item">
                            <a href="${createLink(controller: 'admin')}" class="nav-link">
                                <i class="nav-icon fas fa-users-cog"></i>
                                <p>Administration</p>
                            </a>
                        </li>
                    </g:if>
                </ul>
            </nav>
        </div>
    </aside>

    <!-- Content Wrapper -->
    <div class="content-wrapper">
        <g:layoutBody/>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.2.0/js/adminlte.min.js"></script>
</body>
</html>