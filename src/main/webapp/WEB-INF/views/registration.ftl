<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta lang="ru">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/css/uikit.min.css" />
    <title>Регистрация</title>
    <style>
        .auth-container {
            max-width: 500px;
            margin: 50px auto;
        }
        .hidden {
            display: none;
        }
        .timer {
            color: #999;
            font-size: 0.9em;
            margin-top: 10px;
        }
        .uk-alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="uk-container auth-container">
    <!-- Форма регистрации -->
    <div id="registration-form">
        <div class="uk-card uk-card-large uk-card-default uk-card-body">
            <div class="uk-card-header">
                <h3 class="uk-card-title">Регистрация</h3>
            </div>
            <form id="registerForm">
                <div class="uk-margin">
                    <div class="uk-inline">
                        <span class="uk-form-icon" uk-icon="icon: user"></span>
                        <input id="username" class="uk-input" type="text" name="username" placeholder="Введите имя" required>
                        <span id="username-error" class="uk-text-meta uk-text-small uk-text-danger"></span>
                    </div>
                </div>

                <div class="uk-margin">
                    <div class="uk-inline">
                        <span class="uk-form-icon" uk-icon="icon: mail"></span>
                        <input id="email" class="uk-input" type="email" name="email" placeholder="Введите email" required>
                        <span id="email-error" class="uk-text-meta uk-text-small uk-text-danger"></span>
                    </div>
                </div>

                <div class="uk-margin">
                    <div class="uk-inline">
                        <span class="uk-form-icon uk-form-icon-flip" uk-icon="icon: lock"></span>
                        <input id="password" class="uk-input" type="password" name="password" placeholder="Введите пароль" required>
                        <span id="password-error" class="uk-text-meta uk-text-small uk-text-danger"></span>
                    </div>
                </div>

                <div class="uk-margin">
                    <button type="submit" class="uk-button uk-button-primary uk-width-1-1">Зарегистрироваться</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Форма верификации -->
    <div id="verification-form" class="hidden">
        <div class="uk-card uk-card-large uk-card-default uk-card-body">
            <div class="uk-card-header">
                <h3 class="uk-card-title">Подтверждение email</h3>
            </div>
            <div class="uk-alert uk-alert-success" uk-alert>
                <p>Код подтверждения отправлен на ваш email. Пожалуйста, введите его ниже.</p>
            </div>

            <form id="verifyForm">

                <input id="user-id" type="hidden" name="userId">

                <div class="uk-margin">
                    <div class="uk-inline">
                        <span class="uk-form-icon" uk-icon="icon: lock"></span>
                        <input id="verificationCode" class="uk-input" type="text" name="code" placeholder="Введите код подтверждения" required>
                        <span id="code-error" class="uk-text-meta uk-text-small uk-text-danger"></span>
                    </div>
                </div>

                <div class="uk-margin">
                    <button type="submit" class="uk-button uk-button-primary uk-width-1-1">Подтвердить</button>
                </div>

                <div class="uk-text-center">
                    <a href="#" id="resend-link" class="uk-link-muted uk-disabled">Отправить код повторно (<span id="timer">60</span> сек)</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/js/uikit-icons.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const registerForm = document.getElementById('registerForm');
        const verifyForm = document.getElementById('verifyForm');
        const registrationForm = document.getElementById('registration-form');
        const verificationForm = document.getElementById('verification-form');
        const resendLink = document.getElementById('resend-link');
        const timerElement = document.getElementById('timer');

        // Обработка формы регистрации
        registerForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Здесь должна быть валидация и отправка данных
            const formData = {
                username: document.getElementById('username').value,
                email: document.getElementById('email').value,
                password: document.getElementById('password').value
            };

            // Пример AJAX запроса (замените на реальный)
            fetch('/registration', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            })
                .then(response => response.json())
                .then(data => {
                    if(data.success) {
                        registrationForm.classList.add('hidden');
                        verificationForm.classList.remove('hidden');
                        document.getElementById("user-id").value = data.userId

                        // Запускаем таймер для повторной отправки
                        startResendTimer();
                    } else {
                        // Показываем ошибки
                        UIkit.notification({
                            message: data.message || 'Ошибка регистрации',
                            status: 'danger'
                        });
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    UIkit.notification({
                        message: 'Произошла ошибка',
                        status: 'danger'
                    });
                });
        });

        // Обработка формы верификации
        verifyForm.addEventListener('submit', function(e) {
            e.preventDefault();

            const code = document.getElementById('verificationCode').value;
            const userId = document.getElementById('user-id').value;

            fetch('/registration/verify', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ userId: userId, code: code})
            })
                .then(response => response.json())
                .then(data => {
                    if(data.success) {
                        UIkit.notification({
                            message: 'Email успешно подтвержден!',
                            status: 'success'
                        });
                        // Перенаправление на страницу входа или профиля
                        window.location.href = '/profile';
                    } else {
                        UIkit.notification({
                            message: data.message || 'Неверный код подтверждения',
                            status: 'danger'
                        });
                    }
                });
        });

        // Таймер для повторной отправки
        function startResendTimer() {
            let timeLeft = 60;
            resendLink.classList.add('uk-disabled');

            const timer = setInterval(() => {
                timeLeft--;
                timerElement.textContent = timeLeft;

                if(timeLeft <= 0) {
                    clearInterval(timer);
                    resendLink.classList.remove('uk-disabled');
                }
            }, 1000);
        }

        // Обработка повторной отправки кода
        resendLink.addEventListener('click', function(e) {
            e.preventDefault();

            const userId = document.getElementById('user-id').value;

            if(this.classList.contains('uk-disabled')) return;

            fetch('/registration/resend', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'},
                body: JSON.stringify({userId: userId})
            })
                .then(response => response.json())
                .then(data => {
                    if(data.success) {
                        UIkit.notification({
                            message: 'Код подтверждения отправлен повторно',
                            status: 'success'
                        });
                        startResendTimer();
                    } else {
                        UIkit.notification({
                            message: data.message || 'Ошибка при отправке кода',
                            status: 'danger'
                        });
                    }
                });
        });
    });
</script>
</body>
</html>