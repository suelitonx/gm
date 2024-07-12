/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hpscgpnkos9a60w")

  collection.options = {
    "query": "SELECT b.id, b.name, GROUP_CONCAT(a.jogo, ',') AS liked_games\nFROM likes AS a\nINNER JOIN users AS b ON (a.usuario = b.id AND a.valor = 1)\nGROUP BY b.name;\n"
  }

  // remove
  collection.schema.removeField("7i80fwnw")

  // remove
  collection.schema.removeField("i1stxshb")

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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hpscgpnkos9a60w")

  collection.options = {
    "query": "SELECT b.id, b.name, GROUP_CONCAT(a.id, ',') AS liked_games\nFROM likes AS a\nINNER JOIN users AS b ON (a.usuario = b.id AND a.valor = 1)\nGROUP BY b.name;\n"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "7i80fwnw",
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
    "id": "i1stxshb",
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
  collection.schema.removeField("37onybrs")

  // remove
  collection.schema.removeField("sjx8zkld")

  return dao.saveCollection(collection)
})
