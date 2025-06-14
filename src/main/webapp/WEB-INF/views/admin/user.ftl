<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Профиль пользователя ${user.username}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/css/uikit.min.css">
    <style>
        .user-card {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        .user-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 1rem;
            background-color: #f8f8f8;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #666;
        }
        .user-detail {
            margin-bottom: 0.8rem;
            padding-bottom: 0.8rem;
            border-bottom: 1px solid #f0f0f0;
        }
        .user-detail:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>
<div class="uk-container">
    <div class="user-card uk-card uk-card-default uk-card-body">
        <h2 class="uk-card-title uk-text-center">${user.username}</h2>

        <div class="uk-margin">
            <div class="user-detail">
                <span class="uk-text-bold">ID:</span> ${user.id}
            </div>
            <div class="user-detail">
                <span class="uk-text-bold">Email:</span> ${user.email}
            </div>
            <div class="user-detail">
                <span class="uk-text-bold">Роль:</span>
                <span class="uk-label uk-label-primary">
                    <#if user.roles??>
                        <#list user.roles as role>
                                <#if role.name == 'ROLE_ADMIN'>Администратор
                                <#else>Пользователь</#if>
                        </#list>
                        <#else>Роли нет
                    </#if>

    </span>
            </div>

                <div class="user-detail">
                    <span class="uk-text-bold">Дата рождения:</span>
                    <#if user.birthdate??>${user.birthdate}
                    <#else> Не указано</#if>
                </div>
        </div>

        <div class="uk-flex uk-flex-center uk-grid-small" uk-grid>
            <div>
                <a href="/admin/users/edit/${user.id}"
                   class="uk-button uk-button-primary uk-button-small">
                    <span uk-icon="icon: pencil"></span> Редактировать
                </a>
            </div>
            <div>
                <button onclick="confirmDelete(${user.id})"
                        class="uk-button uk-button-danger uk-button-small">
                    <span uk-icon="icon: trash"></span> Удалить
                </button>
            </div>
            <div>
                <a href="/admin"
                   class="uk-button uk-button-default uk-button-small">
                    <span uk-icon="icon: arrow-left"></span> Назад
                </a>
            </div>
        </div>
    </div>
</div>

<div id="delete-confirm-modal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <h2 class="uk-modal-title">Подтверждение удаления</h2>
        <p>Вы действительно хотите удалить пользователя ${user.username}?</p>
        <p class="uk-text-danger">Это действие нельзя отменить!</p>
        <div class="uk-modal-footer uk-text-right">
            <button class="uk-button uk-button-default uk-modal-close" type="button">Отмена</button>
            <button id="confirm-delete-btn" class="uk-button uk-button-danger" type="button">
                Удалить
            </button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit-icons.min.js"></script>

<script>
    let currentUserIdToDelete = null;

    function confirmDelete(userId) {
        currentUserIdToDelete = userId;
        UIkit.modal('#delete-confirm-modal').show();
    }

    document.getElementById('confirm-delete-btn').addEventListener('click', function() {
        if (currentUserIdToDelete) {
            deleteUser(currentUserIdToDelete);
        }
    });

    function deleteUser(userId) {
        fetch(`/admin/users/delete/${userId}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
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
                    message: 'Ошибка при удалении пользователя',
                    status: 'danger',
                    pos: 'top-center'
                });
            })
            .finally(() => {
                UIkit.modal('#delete-confirm-modal').hide();
            });
    }
</script>
</body>
</html>