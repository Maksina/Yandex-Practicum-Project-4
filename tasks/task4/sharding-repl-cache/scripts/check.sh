echo "Общее количество: $(docker compose exec -T mongos_router mongosh --port 27020 --quiet --eval 'print(db.getSiblingDB("somedb").helloDoc.countDocuments())')"
echo "Документов на shard1: $(docker compose exec -T shard1-1 mongosh --port 27030 --quiet --eval 'print(db.getSiblingDB("somedb").helloDoc.countDocuments())')"
echo "Документов на shard2: $(docker compose exec -T shard2-1 mongosh --port 27040 --quiet --eval 'print(db.getSiblingDB("somedb").helloDoc.countDocuments())')"

echo "Реплики для shard1: $(docker compose exec -T shard1-1 mongosh --port 27030 --quiet --eval 'rs.status().members.map(m => m.name + ":" + m.stateStr).join(", ")')"
echo "Реплики для shard2: $(docker compose exec -T shard2-1 mongosh --port 27040 --quiet --eval 'rs.status().members.map(m => m.name + ":" + m.stateStr).join(", ")')"

# Удерживать окно открытым при ручном запуске
if [ -t 0 ]; then
  echo
  read -p "Нажмите Enter для завершения..."
fi