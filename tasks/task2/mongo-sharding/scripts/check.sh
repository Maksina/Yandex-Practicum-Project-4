echo "Общее количество: $(docker compose exec -T mongos_router mongosh --port 27020 --quiet --eval 'print(db.getSiblingDB("somedb").helloDoc.countDocuments())')"
echo "Документов на shard1: $(docker compose exec -T shard1 mongosh --port 27018 --quiet --eval 'print(db.getSiblingDB("somedb").helloDoc.countDocuments())')"
echo "Документов на shard2: $(docker compose exec -T shard2 mongosh --port 27019 --quiet --eval 'print(db.getSiblingDB("somedb").helloDoc.countDocuments())')"

# Удерживать окно открытым при ручном запуске
if [ -t 0 ]; then
  echo
  read -p "Нажмите Enter для завершения..."
fi