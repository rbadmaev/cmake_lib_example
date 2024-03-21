### Плюсы:
- Простота
- Для работы клиента достаточно передать ему один аргумент - путь до каталога в который была установлена библиотека
- Используется только CMake
    - Библиотека собирается тремя стандартными командами cmake

        ```
        cmake -DCMAKE_INSTALL_PREFIX=installDir libraryDir
        cmake --build .
        cmake --install .
        ```
    - Клинет тоже собирается стандартными командами cmake, но с передачей доп.аргумента

        ```
        cmake -DLIB_DIR=installDir clientDir
        cmake --build .
        ```
- Несколько бинарных файлов в библиотеке не являются проблемой
- Библиотека определяет структуру экспорта:
    - Можно разделить интерфейсные и приватные заголовочные файлы
    - Это разделение не влияет на структуру файлов в проекте библиотеки, а определяется только на шаге установки
- Для передачи бинарников между машинами достаточно просто их скопировать

### Минусы:
- Необходимо передавать клиенту путь до каталога в который установлена библиотека.
- Клиентский проект должен знать структуру экспорта библиотеки. Смена структуры должна происходить согласованно в библиотеке и всех клиентах.
- Клиентский проект должен знать тип библиотеки (динамическая или статическая). Смешивание невозможно.
- Информация о таргетах библиотеки теряется
- Проблемы в случае если библиотека хочет выставить несколько таргетов. Нет способа сообщить клиентам о них, и разделить экспортируемые файлы
- Нет готового способа передачи исходников/бинарников между машинами, и учета двоичной совместимости
- Не поддерживается версионирование. Необходимо решать другими способами, например через сабмодули git-а.
- Достаточно объемный cmake-код клиента, со сканированием папки на предмет наличия в них библиотек.
    Может становиться еще объемнее, при необходимости точно различать библиотеки на разных платформах или автоопределении типа (статическая или динамическая)
