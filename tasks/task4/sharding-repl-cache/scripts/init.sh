#Инициализация configSrv
docker compose exec -T configSrv mongosh --port 27017 --quiet <<EOF
rs.initiate({
  _id: "config_server",
  configsvr: true,
  members: [
    { _id: 0, host: "configSrv:27017" }
  ]
});
EOF

#Инициализация shard1
docker compose exec -T shard1-1 mongosh --port 27030 --quiet <<EOF
rs.initiate({
  _id: "shard1",
  members: [
    { _id: 0, host: "shard1-1:27030" },
    { _id: 1, host: "shard1-2:27031" },
    { _id: 2, host: "shard1-3:27032" }
  ]
});
EOF

#Инициализация shard2
docker compose exec -T shard2-1 mongosh --port 27040 --quiet <<EOF
rs.initiate({
  _id: "shard2",
  members: [
    { _id: 0, host: "shard2-1:27040" },
    { _id: 1, host: "shard2-2:27041" },
    { _id: 2, host: "shard2-3:27042" }
  ]
});
EOF

#Инициализация mongos_router
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
sh.addShard("shard1/shard1-1:27030");
sh.addShard("shard2/shard2-1:27040");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name": "hashed" });
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})
EOF
