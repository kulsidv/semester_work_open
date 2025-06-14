<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/css/uikit.min.css" />
    <title>Вход в аккаунт</title>
</head>
<body>
<form method="post" action="/login">

    <div class="uk-margin">
        <div class="uk-inline">
            <span class="uk-form-icon" uk-icon="icon: user"></span>
            <input class="uk-input" type="text" name="username" aria-label="Not clickable icon" placeholder="Введите имя" required>
        </div>
    </div>

    <div class="uk-margin">
        <div class="uk-inline">
            <span class="uk-form-icon uk-form-icon-flip" uk-icon="icon: lock"></span>
            <input class="uk-input" type="password" name="password" aria-label="Not clickable icon" placeholder="Введите пароль" required>
        </div>
    </div>

    <button type="submit" class="uk-button uk-button-text">Войти</button>
    <a class="uk-link-muted" href="#">Забыли пароль?</a>
</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/js/uikit-icons.min.js"></script>
</html>