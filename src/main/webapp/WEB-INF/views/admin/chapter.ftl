<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Глава ${chapter.chapterNum} - ${chapter.title!''}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/css/uikit.min.css">
    <style>
        .chapter-card {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        .chapter-header {
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
        .paragraph-item {
            padding: 1rem;
            margin-bottom: 1rem;
            background-color: #f9f9f9;
            border-radius: 4px;
            position: relative;
        }
        .paragraph-number {
            position: absolute;
            left: -10px;
            top: -10px;
            background: #1e87f0;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        .test-item {
            padding: 1rem;
            margin-bottom: 1.5rem;
            background-color: #f5f5f5;
            border-radius: 4px;
            border-left: 4px solid #1e87f0;
        }
        .test-question {
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .test-variants {
            margin-left: 1rem;
            margin-bottom: 0.5rem;
        }
        .test-answer {
            font-style: italic;
            color: #666;
        }
    </style>
</head>
<body>
<div class="uk-container">
    <div class="chapter-card uk-card uk-card-default uk-card-body">
        <div class="chapter-header">
            <h1 class="uk-card-title">${chapter.title!''}</h1>
            <div class="uk-text-meta">Порядковый номер: ${chapter.chapterNum!''}</div>
        </div>

        <h3 class="uk-heading-divider">Содержание главы</h3>

        <div class="uk-margin">
            <#if chapter.paragraphs??>
                <#list chapter.paragraphs as paragraph>
                    <div class="paragraph-item">
                        <div class="paragraph-number">${paragraph.orderNum!''}</div>
                        <div class="paragraph-content">${paragraph.text!''}</div>
                    </div>
                </#list>
            <#else>
                <p class="uk-text-muted">В этой главе пока нет параграфов</p>
            </#if>
        </div>

        <h3 class="uk-heading-divider">Тесты главы</h3>

        <div class="uk-margin">
            <#if chapter.tests?? && chapter.tests?size gt 0>
                <#list chapter.tests as test>
                    <div class="test-item">
                        <div class="test-question">${test.question!''}</div>
                        <div class="test-variants">
                            <#if test.vars??>
                                <#list test.vars as variant>
                                    <div>${variant_index + 1}. ${variant!''}</div>
                                </#list>
                            </#if>
                        </div>
                        <div class="test-answer">Правильный ответ: ${test.answer!''}</div>
                    </div>
                </#list>
            <#else>
                <p class="uk-text-muted">В этой главе пока нет тестов</p>
            </#if>
        </div>

        <div class="uk-flex uk-flex-center uk-grid-small" uk-grid>
            <div>
                <a href="/admin/chapters/edit/${chapter.id}"
                   class="uk-button uk-button-primary uk-button-small">
                    <span uk-icon="icon: pencil"></span> Редактировать
                </a>
            </div>
            <div>
                <button onclick="confirmDelete(${chapter.id})"
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

<!-- Модальное окно подтверждения удаления -->
<div id="delete-confirm-modal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <h2 class="uk-modal-title">Подтверждение удаления</h2>
        <p>Вы действительно хотите удалить главу "${chapter.title!''}"?</p>
        <p class="uk-text-danger">Все связанные параграфы также будут удалены!</p>
        <div class="uk-modal-footer uk-text-right">
            <button class="uk-button uk-button-default uk-modal-close" type="button">Отмена</button>
            <button id="confirm-delete-btn" class="uk-button uk-button-danger" type="button">
                Удалить
            </button>
        </div>
    </div>
</div>

<!-- UIkit JS -->
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit-icons.min.js"></script>
<script>
    let currentChapterIdToDelete = null;

    function confirmDelete(chapterId) {
        currentChapterIdToDelete = chapterId;
        UIkit.modal('#delete-confirm-modal').show();
    }

    document.getElementById('confirm-delete-btn').addEventListener('click', function() {
        if (currentChapterIdToDelete) {
            deleteChapter(currentChapterIdToDelete);
        }
    });

    function deleteChapter(chapterId) {
        fetch(`/admin/chapters/delete/` + chapterId, {
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
                    message: 'Ошибка при удалении главы',
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