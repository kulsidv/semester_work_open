<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Анатомия | Онлайн-учебник</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/css/uikit.min.css">
    <style>
        .hero-section {
            background-image: url("/images/background.jpg");
            color: white;
            padding: 80px 0;
            margin-bottom: 30px;
        }

        .chapter-item {
            padding: 12px 15px;
            border-left: 3px solid transparent;
            transition: all 0.3s;
        }
        .chapter-item:hover {
            background-color: #f8f8f8;
            border-left: 3px solid #6e8efb;
        }
        .chapter-item.completed {
            color: #32d296;
        }

        .features-grid {
            margin-top: 40px;
        }
    </style>
</head>
<body>
<!-- Шапка сайта -->
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

<!-- Основной контент -->
<main>
    <!-- Герой-секция -->
    <section class="hero-section">
        <div class="uk-container">
            <div class="uk-grid-match uk-child-width-1-2@m" uk-grid>
                <div>
                    <h1 class="uk-heading-primary">Изучай анатомию легко и интересно!</h1>
                    <p class="uk-text-lead">Интерактивный учебник с понятными объяснениями и наглядными материалами.</p>
                    <button class="uk-button uk-button-primary uk-button-large">Начать обучение</button>
                </div>
            </div>
        </div>
    </section>

    <!-- Основные возможности -->
    <div class="uk-container features-grid">
        <div class="uk-child-width-1-3@m uk-grid-match" uk-grid>
<#--            <div>-->
<#--                <div class="uk-card uk-card-default uk-card-body">-->
<#--                    <h3><span uk-icon="icon: album; ratio: 1.5"></span> 3D-модели</h3>-->
<#--                    <p>Изучайте анатомию с помощью интерактивных 3D-моделей органов и систем организма.</p>-->
<#--                </div>-->
<#--            </div>-->
            <div>
                <div class="uk-card uk-card-default uk-card-body">
                    <h3><span uk-icon="icon: check; ratio: 1.5"></span> Тесты</h3>
                    <p>Проверяйте свои знания с помощью интерактивных тестов после каждой главы.</p>
                </div>
            </div>
            <div>
                <div class="uk-card uk-card-default uk-card-body">
                    <h3><span uk-icon="icon: star; ratio: 1.5"></span> Интересные факты</h3>
                    <p>Узнавайте удивительные факты о человеческом теле, которые не расскажут в школе.</p>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Модальное окно входа -->
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

<!-- Выдвижная панель с содержанием -->
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
            <#list chapters as chapter>
                <li class="chapter-item completed">
                    <a href="/chapter/${chapter.id()}">${chapter.chapterNum()}. ${chapter.title()}</a>
                </li>
            </#list>
        </ul>
    </div>
</div>

<!-- Скрипты -->
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit-icons.min.js"></script>
<script src="/js/index.js"></script>
</body>
</html>