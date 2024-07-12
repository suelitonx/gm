/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.created, a.tipo, b.name\nFROM likes AS a\nINNER JOIN users AS b\nON (a.usuario = b.id AND a.valor = true);"
  }

  // remove
  collection.schema.removeField("r5woplux")

  // remove
  collection.schema.removeField("gh8qufcw")

  // remove
  collection.schema.removeField("fgrnvtqe")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "q12khyvf",
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
    "id": "hltqtkgm",
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
    "id": "kfvkitgl",
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
    "query": "SELECT a.id, a.jogo, a.created, a.tipo, b.name, a.updated\nFROM likes AS a\nINNER JOIN users AS b\nON (a.usuario = b.id AND a.valor = true);"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "r5woplux",
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
    "id": "gh8qufcw",
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
    "id": "fgrnvtqe",
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
  collection.schema.removeField("q12khyvf")

  // remove
  collection.schema.removeField("hltqtkgm")

  // remove
  collection.schema.removeField("kfvkitgl")

  return dao.saveCollection(collection)
})
