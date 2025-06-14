<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><#if path == "edit">Редактирование пользователя ${user.username!''}<#else>Создание пользователя</#if></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/css/uikit.min.css">
    <style>
        .user-form-card {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        .form-header {
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
        .uk-input, .uk-select, .uk-textarea {
            transition: all 0.3s ease;
        }
        .uk-input:focus, .uk-select:focus {
            border-color: #1e87f0;
            box-shadow: 0 0 0 2px rgba(30, 135, 240, 0.2);
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
        }
        .required-field::after {
            content: " *";
            color: #f0506e;
        }
    </style>
</head>
<body>
<div class="uk-container">
    <div class="user-form-card uk-card uk-card-default uk-card-body">
        <div class="form-header">
            <h1 class="uk-card-title">
                <span uk-icon="icon: user; ratio: 1.5"></span>
                <#if path == "edit">Редактирование пользователя<#else>Создание пользователя</#if>
            </h1>
            <#if path == "edit" && user??>
                <div class="uk-text-meta">ID: ${user.id!''}</div>
            </#if>
        </div>

        <form method="post" action="<#if path == "edit">/admin/users/edit<#else>/admin/users/create</#if>" id="userForm">
            <#if path == "edit" && user??>
                <input type="hidden" name="id" value="${user.id!''}">
            </#if>

            <div class="uk-margin">
                <label class="uk-form-label required-field" for="username">Имя пользователя</label>
                <div class="uk-inline uk-width-1-1">
                    <span class="uk-form-icon" uk-icon="icon: user"></span>
                    <input id="username" class="uk-input" type="text" name="username"
                           value="<#if path == "edit" && user??>${user.username!''}</#if>"
                           aria-label="Имя пользователя" required>
                </div>
            </div>

            <div class="uk-margin">
                <label class="uk-form-label required-field" for="email">Email</label>
                <div class="uk-inline uk-width-1-1">
                    <span class="uk-form-icon" uk-icon="icon: mail"></span>
                    <input id="email" class="uk-input" type="email" name="email"
                           value="<#if path == "edit" && user??>${user.email!''}</#if>"
                           aria-label="Email" required>
                </div>
            </div>

            <div class="uk-margin">
                <label class="uk-form-label" for="birthdate">Дата рождения</label>
                <div class="uk-inline uk-width-1-1">
                    <span class="uk-form-icon" uk-icon="icon: calendar"></span>
                    <input id="birthdate" class="uk-input" type="date" name="birthdate"
                           value="<#if path == "edit" && user??>${user.birthdate!''}</#if>"
                           aria-label="Дата рождения">
                </div>
            </div>

            <div class="uk-margin">
                <label class="uk-form-label<#if path == "create"> required-field</#if>" for="password">
                    <#if path == "edit">Новый пароль<#else>Пароль</#if>
                </label>
                <div class="uk-inline uk-width-1-1" style="position: relative;">
                    <span class="uk-form-icon" uk-icon="icon: lock"></span>
                    <input id="password" class="uk-input" type="password" name="password"
                           aria-label="Пароль" <#if path == "create">required<#else>placeholder="Оставьте пустым, чтобы не изменять"</#if>>
                    <span class="password-toggle" uk-icon="icon: eye" onclick="togglePassword()"></span>
                </div>
                <div class="uk-text-meta uk-margin-small-top">Минимум 8 символов</div>
            </div>

            <div class="uk-margin">
                <label class="uk-form-label">Роли пользователя</label>
                <div class="uk-grid-small" uk-grid>
                    <div class="uk-width-1-1">
                        <label>
                            <input class="uk-checkbox" type="checkbox" name="roles" value="ROLE_USER"
                                   <#if path == "create" || (user?? && user.roles?seq_contains('ROLE_USER'))>checked</#if>>
                            Обычный пользователь (ROLE_USER)
                        </label>
                    </div>
                    <div class="uk-width-1-1">
                        <label>
                            <input class="uk-checkbox" type="checkbox" name="roles" value="ROLE_ADMIN"
                                   <#if user?? && user.roles?seq_contains('ROLE_ADMIN')>checked</#if>>
                            Администратор (ROLE_ADMIN)
                        </label>
                    </div>
                </div>
            </div>

            <div class="uk-margin uk-flex uk-flex-between">
                <a href="/admin" class="uk-button uk-button-default">
                    <span uk-icon="icon: arrow-left"></span> Назад
                </a>
                <button type="submit" class="uk-button uk-button-primary">
                    <span uk-icon="icon: check"></span>
                    <#if path == "edit">Сохранить изменения<#else>Создать пользователя</#if>
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit-icons.min.js"></script>

<script>
    // Переключение видимости пароля
    function togglePassword() {
        const passwordField = document.getElementById('password');
        const icon = document.querySelector('.password-toggle');
        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            icon.setAttribute('uk-icon', 'icon: eye-slash');
        } else {
            passwordField.type = 'password';
            icon.setAttribute('uk-icon', 'icon: eye');
        }
    }

    // Обработка формы
    document.getElementById('userForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);
        const roles = Array.from(document.querySelectorAll('input[name="roles"]:checked'))
            .map(checkbox => checkbox.value);

        const userData = {
            <#if path == "edit">id: formData.get('id'),</#if>
            username: formData.get('username'),
            email: formData.get('email'),
            birthdate: formData.get('birthdate'),
            password: formData.get('password'),
            roles: roles
        };

        fetch(this.action, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(userData)
        })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                } else {
                    return response.json();
                }
            })
            .then(data => {
                if (data && data.redirect) {
                    window.location.href = data.redirect;
                } else if (data && data.error) {
                    UIkit.notification({
                        message: data.error,
                        status: 'danger',
                        pos: 'top-center'
                    });
                }
            })
            .catch(error => {
                console.error('Error:', error);
                UIkit.notification({
                    message: 'Ошибка при сохранении',
                    status: 'danger',
                    pos: 'top-center'
                });
            });
    });
</script>
</body>
</html>