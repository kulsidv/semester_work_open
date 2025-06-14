<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/css/uikit.min.css">
</head>

<body>
<div class="uk-container" id="main-content">
    <div class="uk-grid-small" uk-grid>
        <div class="uk-width-1-2">
            <div class="uk-margin">
                <label class="uk-form-label">WebSocket connection:</label>
                <div class="uk-button-group">
                    <button id="connect" class="uk-button uk-button-default">Connect</button>
                    <button id="disconnect" class="uk-button uk-button-default" disabled>Disconnect</button>
                </div>
            </div>
        </div>

        <div class="uk-width-1-2">
            <div class="uk-margin">
                <label class="uk-form-label" for="name">Введите имя</label>
                <input class="uk-input" type="text" id="name" placeholder="Ваше имя">
            </div>
            <div class="uk-margin">
                <label class="uk-form-label" for="message">Сообщение:</label>
                <input class="uk-input" type="text" id="message" placeholder="Текст сообщения">
            </div>
            <button id="send" class="uk-button uk-button-default">ОТправить сообщение</button>
        </div>
    </div>

    <div class="uk-margin">
        <table class="uk-table uk-table-striped">
            <thead>
            <tr>
                <th>Сообщения</th>
            </tr>
            </thead>
            <tbody id="messages"></tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script src="/js/message.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit-icons.min.js"></script>

</body>
</html>