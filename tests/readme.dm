# Зависимости
Для автотестирования используется [bats](https://github.com/bats-core/bats-core).
Для его установки достаточно склонировать репозиторий, установить в любой префикс, который доступен в переменной окружения `PATH`
```
git clone https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh <prefix>
```
После этого можно запускать тесты из папки tests простой комадной
```
./tests.sh
```
