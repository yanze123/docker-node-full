# 后台启动 Mongodb
mongod --fork --logpath=/var/log/mongo.log --logappend

node app.js