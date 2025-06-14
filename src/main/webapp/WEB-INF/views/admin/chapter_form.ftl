<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>
        <#if path == "create">Создание главы
        <#elseif path == "edit">Редактирование главы
        </#if>
    </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.23.6/dist/css/uikit.min.css">
</head>
<body>
<div class="uk-container uk-margin-top">
    <form method="post" action="/admin/chapters/${path}" id="chapterForm">
        <#if path == "edit" && chapter??>
            <input type="hidden" name="id" value="${chapter.id}">
        </#if>

        <div class="uk-margin">
            <label class="uk-form-label" for="title">Название главы</label>
            <div class="uk-inline uk-width-1-1">
                <input id="title" class="uk-input" type="text" name="title"
                       <#if path == "edit" && chapter??>value="${chapter.title!''}"</#if>
                       aria-label="Название главы" required>
            </div>
        </div>

        <div class="uk-margin">
            <label class="uk-form-label" for="orderNumber">Порядковый номер</label>
            <div class="uk-inline uk-width-1-1">
                <input id="chapterNum" class="uk-input" type="number" name="chapterNum"
                       <#if path == "edit" && chapter??>value="${chapter.chapterNum!''}"</#if>
                       aria-label="Порядковый номер" required min="1">
            </div>
        </div>

        <div class="uk-margin">
            <h3>Параграфы</h3>
            <div id="paragraphsContainer">
                <#if path == "create">
                    <div class="paragraph-item uk-margin" data-index="0">
                        <div class="uk-grid-small" uk-grid>
                            <div class="uk-width-1-6">
                                <input type="number" class="uk-input paragraph-order" name="paragraphs[0].orderNumber" value="1" min="1" required>
                            </div>
                            <div class="uk-width-4-6">
                                <textarea class="uk-textarea" name="paragraphs[0].content" required maxlength="2000"></textarea>
                            </div>
                            <div class="uk-width-1-6 uk-flex uk-flex-middle">
                                <button type="button" class="uk-button uk-button-danger uk-button-small remove-paragraph" uk-icon="trash"></button>
                            </div>
                        </div>
                    </div>
                <#elseif path == "edit" && chapter?? && chapter.paragraphs??>
                    <#list chapter.paragraphs as paragraph>
                        <div class="paragraph-item uk-margin" data-index="${paragraph?index}">
                            <input type="hidden" name="paragraphs[${paragraph?index}].id" value="${paragraph.id}">
                            <div class="uk-grid-small" uk-grid>
                                <div class="uk-width-1-6">
                                    <input type="number" class="uk-input paragraph-order"
                                           name="paragraphs[${paragraph?index}].orderNumber"
                                           value="${paragraph.orderNum}" min="1" required>
                                </div>
                                <div class="uk-width-4-6">
                                    <textarea class="uk-textarea" name="paragraphs[${paragraph?index}].content" required>${paragraph.text}</textarea>
                                </div>
                                <div class="uk-width-1-6 uk-flex uk-flex-middle">
                                    <button type="button" class="uk-button uk-button-danger uk-button-small remove-paragraph" uk-icon="trash"></button>
                                </div>
                            </div>
                        </div>
                    </#list>
                </#if>
            </div>

            <button type="button" id="addParagraph" class="uk-button uk-button-primary uk-button-small" uk-icon="plus"></button>
        </div>

        <!-- Новая секция для тестов -->
        <div class="uk-margin">
            <h3>Тесты</h3>
            <div id="testsContainer">
                <#if path == "create">
                    <div class="test-item uk-margin uk-card uk-card-default uk-card-body" data-index="0">
                        <div class="uk-margin">
                            <label class="uk-form-label">Вопрос</label>
                            <input type="text" class="uk-input" name="tests[0].question" required placeholder="Введите вопрос">
                        </div>

                        <div class="uk-margin">
                            <label class="uk-form-label">Правильный ответ</label>
                            <input type="text" class="uk-input" name="tests[0].answer" required placeholder="Введите правильный ответ">
                        </div>

                        <div class="uk-margin">
                            <label class="uk-form-label">Варианты ответов</label>
                            <div class="variants-container" data-test-index="0">
                                <div class="uk-grid-small uk-margin-bottom" uk-grid>
                                    <div class="uk-width-5-6">
                                        <input type="text" class="uk-input" name="tests[0].vars[]" required placeholder="Вариант ответа">
                                    </div>
                                    <div class="uk-width-1-6">
                                        <button type="button" class="uk-button uk-button-danger uk-button-small remove-variant" uk-icon="trash"></button>
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="uk-button uk-button-primary uk-button-small add-variant" data-test-index="0" uk-icon="plus">Добавить вариант</button>
                        </div>

                        <button type="button" class="uk-button uk-button-danger uk-button-small remove-test" uk-icon="trash">Удалить тест</button>
                    </div>
                <#elseif path == "edit" && chapter?? && chapter.tests??>
                    <#list chapter.tests as test>
                        <div class="test-item uk-margin uk-card uk-card-default uk-card-body" data-index="${test?index}">
                            <input type="hidden" name="tests[${test?index}].id" value="${test.id}">
                            <div class="uk-margin">
                                <label class="uk-form-label">Вопрос</label>
                                <input type="text" class="uk-input" name="tests[${test?index}].question" value="${test.question}" required>
                            </div>

                            <div class="uk-margin">
                                <label class="uk-form-label">Правильный ответ</label>
                                <input type="text" class="uk-input" name="tests[${test?index}].answer" value="${test.answer}" required>
                            </div>

                            <div class="uk-margin">
                                <label class="uk-form-label">Варианты ответов</label>
                                <div class="variants-container" data-test-index="${test?index}">
                                    <#list test.vars as variant>
                                        <div class="uk-grid-small uk-margin-bottom" uk-grid>
                                            <div class="uk-width-5-6">
                                                <input type="text" class="uk-input" name="tests[${test?index}].vars[]" value="${variant}" required>
                                            </div>
                                            <div class="uk-width-1-6">
                                                <button type="button" class="uk-button uk-button-danger uk-button-small remove-variant" uk-icon="trash"></button>
                                            </div>
                                        </div>
                                    </#list>
                                </div>
                                <button type="button" class="uk-button uk-button-primary uk-button-small add-variant" data-test-index="${test?index}" uk-icon="plus">Добавить вариант</button>
                            </div>

                            <button type="button" class="uk-button uk-button-danger uk-button-small remove-test" uk-icon="trash">Удалить тест</button>
                        </div>
                    </#list>
                </#if>
            </div>

            <button type="button" id="addTest" class="uk-button uk-button-primary uk-button-small" uk-icon="plus">Добавить тест</button>
        </div>

        <div class="uk-margin">
            <button type="submit" class="uk-button uk-button-primary">
                <#if path == "create">Создать главу
                <#else>Сохранить изменения
                </#if>
            </button>
        </div>
    </form>
</div>
</body>
<script src="/admin/js/chapter_form.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit-icons.min.js"></script>
</html>