/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.created, a.tipo, b.name\nFROM likes AS a\nINNER JOIN users AS b\nON (a.usuario = b.id AND a.valor = true);"
  }

  // remove
  collection.schema.removeField("6z5vvrts")

  // remove
  collection.schema.removeField("3b6yhdqs")

  // remove
  collection.schema.removeField("mgdyzrd2")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "7cub2o80",
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
    "id": "wdyr9mqy",
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
    "id": "tn5rubsx",
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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.created, a.tipo, b.name\nFROM likes AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "6z5vvrts",
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
    "id": "3b6yhdqs",
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
    "id": "mgdyzrd2",
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
  collection.schema.removeField("7cub2o80")

  // remove
  collection.schema.removeField("wdyr9mqy")

  // remove
  collection.schema.removeField("tn5rubsx")

  return dao.saveCollection(collection)
})
