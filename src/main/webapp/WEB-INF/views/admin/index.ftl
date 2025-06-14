<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Администрирование сайта</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/css/uikit.min.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .admin-nav {
            background: #1e87f0;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .admin-nav ul {
            margin: 0;
            padding: 0;
            display: flex;
        }
        .admin-nav li {
            list-style: none;
        }
        .admin-nav button {
            color: white;
            padding: 15px 25px;
            background: transparent;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }
        .admin-nav button:hover {
            background: rgba(255,255,255,0.1);
        }
        .admin-nav button.uk-active {
            background: rgba(255,255,255,0.2);
            font-weight: bold;
        }
        .content-card {
            background: white;
            border-radius: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .uk-table {
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .uk-table th {
            background: #f8f8f8;
        }
        .action-buttons .uk-button {
            padding: 0 10px;
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="admin-container">
    <nav class="admin-nav">
        <ul>
            <li><button class="uk-active" type="button" id="chapters">Главы</button></li>
            <li><button type="button" id="users">Пользователи</button></li>
        </ul>
    </nav>

    <div class="content-card">
        <div class="section-header">
            <h2 id="section-title">Главы</h2>
            <div id="add">

            </div>
        </div>

        <div class="uk-overflow-auto">
            <table id="table" class="data-table">
            </table>
        </div>

        <div id="pagination" class="pagination"></div>
    </div>
</div>

<!-- UIkit JS -->
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.0/dist/js/uikit-icons.min.js"></script>

<!-- Ваши скрипты -->
<script src="/admin/js/pagination.js" type="module"></script>
<script src="/admin/js/chapters.js" type="module"></script>
<script src="/admin/js/users.js" type="module"></script>

<script type="module">
    import { setupNavigation } from '/admin/js/navigation.js';
    import { loadChapters } from "/admin/js/chapters.js";

    document.addEventListener('DOMContentLoaded', () => {
        setupNavigation();
        loadChapters(0);
    });
</script>
</body>
</html>