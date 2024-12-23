<!doctype html>
<html>
<head>
  <meta name="layout" content="main"/>
  <title>Login</title>
  <asset:stylesheet href="application.css"/>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card mt-5">
        <div class="card-header">
          <h3 class="text-center">Login</h3>
        </div>
        <div class="card-body">
          <g:if test='${flash.message}'>
            <div class="alert alert-danger">${flash.message}</div>
          </g:if>
          <form action="${postUrl ?: '/login/authenticate'}" method="POST" autocomplete="off">
            <div class="form-group">
              <label>Username</label>
              <input type="text" class="form-control" name="username" id="username" required>
            </div>
            <div class="form-group">
              <label>Password</label>
              <input type="password" class="form-control" name="password" id="password" required>
            </div>
            <div class="form-group">
              <div class="checkbox">
                <label>
                  <input type="checkbox" name="remember-me"> Remember me
                </label>
              </div>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Login</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
