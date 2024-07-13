/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.updated, a.tipo, b.name, b.id as id_usuario\nFROM likes AS a\nINNER JOIN users AS b\nON (a.usuario = b.id AND a.valor = true);"
  }

  // remove
  collection.schema.removeField("vjbiihmf")

  // remove
  collection.schema.removeField("1fathte6")

  // remove
  collection.schema.removeField("zdpuxlxq")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fp39m0qc",
    "name": "jogo",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "mqhvccqj",
    "name": "tipo",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": 1,
      "max": 3,
      "noDecimal": true
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fu3plhkg",
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
    "id": "1qh6ydhc",
    "name": "id_usuario",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "_pb_users_auth_",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.updated, a.tipo, b.name\nFROM likes AS a\nINNER JOIN users AS b\nON (a.usuario = b.id AND a.valor = true);"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "vjbiihmf",
    "name": "jogo",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "1fathte6",
    "name": "tipo",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": 1,
      "max": 3,
      "noDecimal": true
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "zdpuxlxq",
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

  // remove
  collection.schema.removeField("fp39m0qc")

  // remove
  collection.schema.removeField("mqhvccqj")

  // remove
  collection.schema.removeField("fu3plhkg")

  // remove
  collection.schema.removeField("1qh6ydhc")

  return dao.saveCollection(collection)
})
