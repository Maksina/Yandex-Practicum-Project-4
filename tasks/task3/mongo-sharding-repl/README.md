# mongo-sharding-repl

## Как запустить

Запуск приложения и БД

```shell
docker compose up -d
```

Инициализация и заполнение данными

```shell
./scripts/init.sh
```

## Как проверить

Проверка количества документов в БД и репликаций

```shell
./scripts/check.sh
```