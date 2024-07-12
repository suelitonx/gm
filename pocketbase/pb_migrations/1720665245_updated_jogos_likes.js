/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hpscgpnkos9a60w")

  collection.options = {
    "query": "SELECT b.id, b.name, GROUP_CONCAT(a.jogo, ',') AS liked_games\nFROM likes AS a\nINNER JOIN users AS b ON (a.usuario = b.id AND a.valor = true)\nGROUP BY b.name;\n"
  }

  // remove
  collection.schema.removeField("37onybrs")

  // remove
  collection.schema.removeField("sjx8zkld")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "eppl3ack",
    "name": "name",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "5ugqyru4",
    "name": "liked_games",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hpscgpnkos9a60w")

  collection.options = {
    "query": "SELECT b.id, b.name, GROUP_CONCAT(a.jogo, ',') AS liked_games\nFROM likes AS a\nINNER JOIN users AS b ON (a.usuario = b.id AND a.valor = 1)\nGROUP BY b.name;\n"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "37onybrs",
    "name": "name",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "sjx8zkld",
    "name": "liked_games",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("eppl3ack")

  // remove
  collection.schema.removeField("5ugqyru4")

  return dao.saveCollection(collection)
})
