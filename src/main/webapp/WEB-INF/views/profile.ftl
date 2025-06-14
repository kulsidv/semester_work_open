<!DOCTYPE html>
<html lang="ru" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Профиль ${user.username}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/css/uikit.min.css"/>
    <style>
        :root {
            --primary-color: #1e87f0;
            --secondary-color: #32d296;
            --dark-color: #222;
            --light-color: #f8f8f8;
        }

        body {
            background-color: #f9f9f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .profile-header {
            background: linear-gradient(135deg, #1e87f0 0%, #32d296 100%);
            padding: 80px 0 160px; /* Увеличил нижний padding */
            text-align: center;
            color: white;
            position: relative;
            margin-bottom: 80px; /* Увеличил отступ снизу */
        }

        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            margin: 0 auto;
            position: relative;
            top: 50px;
            background: white;
        }

        .profile-picture img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .user-info-container {
            margin-top: 70px; /* Опустил блок с именем ниже */
        }

        .user-name {
            font-size: 2rem;
            font-weight: 600;
            color: white;
            margin-bottom: 5px;
        }

        .user-role {
            color: rgba(255,255,255,0.8);
            font-size: 1.1rem;
        }

        /* Остальные стили остаются без изменений */
        .profile-content {
            max-width: 1000px;
            margin: 0 auto 50px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            padding: 40px;
            position: relative;
        }

        .profile-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .info-label {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .info-value {
            color: var(--dark-color);
            font-size: 1.1rem;
            margin-bottom: 20px;
        }

        .profile-actions {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 40px 0;
        }

        .progress-section {
            margin: 50px 0;
            padding: 30px;
            background: var(--light-color);
            border-radius: 8px;
        }

        .progress-title {
            text-align: center;
            color: var(--dark-color);
            margin-bottom: 20px;
            font-size: 1.3rem;
        }

        .chapters-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 15px;
            margin-top: 30px;
        }

        .chapter-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-left: 4px solid var(--primary-color);
            transition: transform 0.3s;
        }

        .chapter-card:hover {
            transform: translateY(-3px);
        }

        .chapter-title {
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark-color);
        }

        .chapter-progress {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .progress-percent {
            margin-left: 10px;
            font-weight: 600;
            color: var(--primary-color);
        }

        .empty-state {
            text-align: center;
            color: #777;
            padding: 40px 0;
            font-size: 1.1rem;
        }

        .empty-state i {
            font-size: 2rem;
            margin-bottom: 15px;
            color: #ccc;
        }
    </style>
</head>
<body>
<header>
    <div class="uk-container">
        <nav class="uk-navbar-container" uk-navbar>
            <div class="uk-navbar-left">
                <a href="/" class="uk-navbar-item uk-logo uk-link-muted">Анатомия</a>
            </div>
            <div class="uk-navbar-right">
                <#if user??>
                    <div id="profile-section">
                        <a href="/profile" uk-toggle class="uk-button uk-button-default">Профиль</a>
                    </div>
                    <div id="logout-section">
                        <a href="/logout" uk-toggle class="uk-button uk-button-default">Выйти</a>
                    </div>
                <#else>
                    <div id="auth-section">
                        <a href="#login-modal" uk-toggle class="uk-button uk-button-default">Войти</a>
                    </div>
                </#if>
                <a class="uk-navbar-toggle" uk-toggle="target: #offcanvas-nav" href="#">
                    <span uk-navbar-toggle-icon></span>
                    <span class="uk-margin-small-left">Меню</span>
                </a>
            </div>
        </nav>
    </div>
</header>

<div class="profile-header">
    <div class="profile-picture">
        <img src="/images/unknown-user.png" alt="Profile Picture">
    </div>
    <div class="user-info-container">
        <h1 class="user-name">${user.username}</h1>
        <div class="user-role">Ученик</div>
    </div>
</div>

<!-- Остальная часть кода остается без изменений -->
<div class="profile-content">
    <div class="profile-info">
        <div class="info-column">
            <div class="info-item">
                <div class="info-label">Имя пользователя</div>
                <div class="info-value">${user.username}</div>
            </div>
            <div class="info-item">
                <div class="info-label">Email</div>
                <div class="info-value">${user.email}</div>
            </div>
        </div>
        <div class="info-column">
            <div class="info-item">
                <div class="info-label">Дата регистрации</div>
                <div class="info-value">${user.createdAt}</div>
            </div>
            <div class="info-item">
                <div class="info-label">День рождения</div>
                <div class="info-value">
                    <#if user.birthdate??>
                        ${user.birthdate}
                    <#else>
                        Не указано
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <div class="profile-actions">
        <button id="edit" type="button" class="uk-button uk-button-primary">
            <i class="fas fa-edit"></i> Редактировать профиль
        </button>
        <button type="button" class="uk-button uk-button-danger" id="delete-btn">
            <i class="fas fa-trash-alt"></i> Удалить аккаунт
        </button>
    </div>

    <div class="progress-section">
        <h3 class="progress-title">Ваш прогресс обучения</h3>
        <div class="uk-margin">
            <div class="uk-flex uk-flex-between uk-flex-middle">
                <span class="uk-text-meta">Пройдено ${user.progresses?size} из ${chapters?size} глав</span>
                <span class="uk-text-meta uk-text-bold">${(user.progresses?size / chapters?size * 100)?round}%</span>
            </div>
            <progress class="uk-progress" value="${user.progresses?size}" max="${chapters?size}"></progress>
        </div>

        <#if !user.progresses?has_content>
            <div class="empty-state">
                <i class="fas fa-book-open"></i>
                <p>Вы пока ничего не прошли</p>
            </div>
        <#else>
            <h4 class="uk-heading-line uk-text-center"><span>Пройденные главы</span></h4>
            <div class="chapters-list">
                <#list user.progresses as progress>
                    <div class="chapter-card">
                        <div class="chapter-title">${progress.chapter.title}</div>
                        <div class="chapter-progress">
                            <progress class="uk-progress" value="${progress.testResult}" max="100" style="width: 80%;"></progress>
                            <span class="progress-percent">${progress.testResult}%</span>
                        </div>
                    </div>
                </#list>
            </div>
        </#if>
    </div>
</div>

<!-- Модальные окна и остальной код остаются без изменений -->
<div id="edit-modal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <button class="uk-modal-close-default" type="button" uk-close></button>
        <h2 class="uk-modal-title">Редактирование профиля</h2>
        <form method="post" action="/profile" id="form">
            <div class="uk-margin">
                <label class="uk-form-label" for="username">Имя пользователя</label>
                <div class="uk-form-controls">
                    <input id="username" class="uk-input" type="text" name="username"
                           value="${user.username}" placeholder="Имя пользователя" required>
                    <span id="username-error" class="uk-text-danger"></span>
                </div>
            </div>

            <div class="uk-margin">
                <label class="uk-form-label" for="email">Email</label>
                <div class="uk-form-controls">
                    <input id="email" class="uk-input" type="email" name="email"
                           value="${user.email}" placeholder="Email" required>
                    <span id="email-error" class="uk-text-danger"></span>
                </div>
            </div>

            <div class="uk-margin">
                <label class="uk-form-label" for="birthdate">Дата рождения</label>
                <div class="uk-form-controls">
                    <input id="birthdate" class="uk-input" type="date" name="birthdate"
                           value="<#if user.birthdate??>${user.birthdate}</#if>">
                    <span id="birthdate-error" class="uk-text-danger"></span>
                </div>
            </div>

            <div class="uk-margin">
                <label class="uk-form-label" for="password">Пароль для подтверждения</label>
                <div class="uk-form-controls">
                    <input id="password" class="uk-input" type="password" name="password"
                           placeholder="Введите пароль для подтверждения" required>
                    <span id="password-error" class="uk-text-danger"></span>
                </div>
            </div>

            <div class="uk-modal-footer uk-text-right">
                <button class="uk-button uk-button-default uk-modal-close" type="button">Отменить</button>
                <button type="submit" class="uk-button uk-button-primary" id="editBtn">Сохранить</button>
            </div>
        </form>
    </div>
</div>

<div id="delete-modal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <button class="uk-modal-close-default" type="button" uk-close></button>
        <h2 class="uk-modal-title">Подтверждение удаления</h2>
        <p>Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить.</p>
        <form id="deleteForm" method="post" action="/profile/delete">
            <div class="uk-margin">
                <label class="uk-form-label">Пароль для подтверждения</label>
                <div class="uk-form-controls">
                    <input class="uk-input" type="password" name="password"
                           placeholder="Введите пароль для подтверждения" required>
                </div>
            </div>
            <div class="uk-modal-footer uk-text-right">
                <button class="uk-button uk-button-default uk-modal-close" type="button">Отменить</button>
                <button type="submit" class="uk-button uk-button-danger">Удалить аккаунт</button>
            </div>
        </form>
    </div>
</div>

<div id="offcanvas-nav" uk-offcanvas="overlay: true">
    <div class="uk-offcanvas-bar">
        <button class="uk-offcanvas-close" type="button" uk-close></button>

        <h3>Содержание учебника</h3>

        <#if user??>
            <div class="uk-margin">
                <span class="uk-text-meta">Ваш прогресс: ${(user.progresses?size / chapters?size * 100)?round}%</span>
                <progress class="uk-progress" value="${user.progresses?size}" max="${chapters?size}"></progress>
            </div>
        </#if>

        <ul class="uk-nav uk-nav-default">
            <#list chapters as chapter>
                <li class="chapter-item completed">
                    <a href="/chapter/${chapter.id()}">${chapter.chapterNum()}. ${chapter.title()}</a>
                </li>
            </#list>
        </ul>
    </div>
</div>

<script src="/js/validation.js" type="module"></script>
<script src="/js/profile-edit.js" type="module"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/js/uikit-icons.min.js"></script>
<script>
    document.getElementById('edit').addEventListener('click', function() {
        UIkit.modal('#edit-modal').show();
    });

    document.getElementById('delete-btn').addEventListener('click', function() {
        UIkit.modal('#delete-modal').show();
    });

    document.getElementById("deleteForm").addEventListener("submit", (event) => {
        event.preventDefault();

        if (confirm('Вы уверены?')) {
            fetch(`http://localhost:8081/profile/delete`, {
                method: 'DELETE'
            }).then(response => response.json())
                .then(data => {
                    if (data.redirect) {
                        window.location.href = data.redirect;
                    } else {
                        alert(data.error);
                    }
                })
        }
    })
</script>
</body>
</html>