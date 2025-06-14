<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Глава ${chapter.chapterNum} - ${chapter.title}</title>
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
            padding-top: 0;
        }

        /* Шапка как в профиле */
        header {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .uk-navbar-container {
            background-color: white !important;
        }

        /* Контейнер главы */
        .chapter-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .chapter-header {
            margin-bottom: 40px;
            text-align: center;
        }

        .chapter-title {
            font-size: 2.5rem;
            font-weight: 300;
            color: #333;
            margin-bottom: 10px;
        }

        .chapter-number {
            font-size: 1.2rem;
            color: #666;
        }

        .paragraph {
            margin-bottom: 30px;
            line-height: 1.8;
            font-size: 1.1rem;
            color: #444;
            text-align: justify;
            padding: 0 10px;
        }

        /* Стили для тестов */
        .test-section {
            margin: 50px 0;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
        }

        .test-title {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-bottom: 20px;
            text-align: center;
        }

        .test-item {
            margin-bottom: 25px;
            padding: 20px;
            background-color: #f8f8f8;
            border-radius: 6px;
            border-left: 4px solid var(--primary-color);
        }

        .test-question {
            font-weight: 600;
            margin-bottom: 15px;
            color: #333;
        }

        .test-variant {
            display: block;
            position: relative;
            padding-left: 35px;
            margin-bottom: 12px;
            cursor: pointer;
            font-size: 1rem;
            color: #555;
            user-select: none;
        }

        .test-variant input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }

        .checkmark {
            position: absolute;
            top: 0;
            left: 0;
            height: 20px;
            width: 20px;
            background-color: #eee;
            border-radius: 50%;
        }

        .test-variant:hover input ~ .checkmark {
            background-color: #ddd;
        }

        .test-variant input:checked ~ .checkmark {
            background-color: var(--primary-color);
        }

        .checkmark:after {
            content: "";
            position: absolute;
            display: none;
        }

        .test-variant input:checked ~ .checkmark:after {
            display: block;
        }

        .test-variant .checkmark:after {
            top: 6px;
            left: 6px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: white;
        }

        .submit-btn {
            display: block;
            margin: 30px auto 0;
            padding: 12px 30px;
        }

        @media (max-width: 768px) {
            .chapter-title {
                font-size: 2rem;
            }
            .paragraph {
                font-size: 1rem;
            }
            .test-section {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<!-- Шапка как в профиле -->
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
                <!-- Кнопка меню с бургером -->
                <a class="uk-navbar-toggle" uk-toggle="target: #offcanvas-nav" href="#">
                    <span uk-navbar-toggle-icon></span>
                    <span class="uk-margin-small-left">Меню</span>
                </a>
            </div>
        </nav>
    </div>
</header>

<!-- Контент главы -->
<div class="uk-container chapter-container">
    <div class="chapter-header">
        <div class="chapter-number">Глава ${chapter.chapterNum}</div>
        <h1 class="chapter-title">${chapter.title}</h1>
        <hr class="uk-divider-icon">
    </div>

    <div class="chapter-content">
        <#list chapter.paragraphs as p>
            <p class="paragraph uk-animation-slide-bottom-small" style="animation-delay: ${p?index * 0.05}s">
                ${p.text}
            </p>
            <#if !p?is_last>
                <div class="uk-margin-medium"></div>
            </#if>
        </#list>
    </div>

    <!-- Секция с тестами -->
    <#if chapter.tests?? && chapter.tests?size gt 0>
        <div class="test-section">
            <h3 class="test-title">Проверьте свои знания</h3>
            <form id="tests-form" action="/chapter/${chapter.id}" method="post">
                <#list chapter.tests as test>
                    <div class="test-item" data-test-id="${test.id}">
                        <div class="test-question">${test.question}</div>
                        <#if test.vars??>
                            <#list test.vars as variant>
                                <label class="test-variant">
                                    <input type="radio" name="test_${test.id}" value="${variant}" required>
                                    <span class="checkmark"></span>
                                    ${variant}
                                </label>
                            </#list>
                        </#if>
                    </div>
                </#list>
                <button type="submit" class="uk-button uk-button-primary submit-btn">Проверить ответы</button>
            </form>
            <div id="test-result" class="uk-margin-top" style="display: none;">
                <div class="uk-alert" id="result-message"></div>
            </div>
        </div>
    </#if>
</div>

<!-- Кнопка "Наверх" -->
<div class="uk-margin-large-top uk-text-center">
    <a href="#" class="uk-button uk-button-text uk-text-muted">
        <span uk-icon="icon: arrow-up"></span> Наверх
    </a>
</div>

<!-- Боковое меню -->
<div id="offcanvas-nav" uk-offcanvas="overlay: true">
    <div class="uk-offcanvas-bar">
        <button class="uk-offcanvas-close" type="button" uk-close></button>

        <h3>Содержание учебника</h3>

        <!-- Прогресс-бар -->
        <#if user??>
            <div class="uk-margin3">
                <span class="uk-text-meta">Ваш прогресс: ${(user.progresses?size / chapters?size * 100)?round}%</span>
                <progress class="uk-progress" value="${user.progresses?size}" max="${chapters?size}"  style="width: 100%;"></progress>
            </div>
        </#if>

        <!-- Список глав -->
        <ul class="uk-nav uk-nav-default">
            <#list chapters as ch>
                <li class="chapter-item completed">
                    <a href="/chapter/${ch.id()}">${ch.chapterNum()}. ${ch.title()}</a>
                </li>
            </#list>
        </ul>
    </div>
</div>
<div id="login-modal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <button class="uk-modal-close-default" type="button" uk-close></button>
        <h2 class="uk-modal-title">Вход в аккаунт</h2>
        <form method="post" action="/login">
            <div class="uk-margin">
                <input class="uk-input" type="text" name="username" placeholder="username" required>
            </div>
            <div class="uk-margin">
                <input class="uk-input" type="password" name="password" placeholder="Пароль" required>
            </div>
            <div class="uk-margin">
                <button class="uk-button uk-button-primary" type="submit">Войти</button>
            </div>
            <div class="uk-text-small">
                Нет аккаунта? <a href="/registration">Зарегистрироваться</a>
            </div>
        </form>
    </div>
</div>

<!-- UIkit JS -->
<script src="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/js/uikit-icons.min.js"></script>
<script src="/js/chapter.js"></script>
</body>
</html>