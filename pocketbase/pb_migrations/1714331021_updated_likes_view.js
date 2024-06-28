/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.created, a.tipo, b.name\nFROM likes AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // remove
  collection.schema.removeField("l86qfots")

  // remove
  collection.schema.removeField("hitouf6h")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "amadv2m1",
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
    "id": "4b3ryjes",
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
    "id": "kzl6oajc",
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
    "query": "SELECT a.id, a.jogo, a.created, b.name\nFROM likes AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "l86qfots",
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
    "id": "hitouf6h",
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
  collection.schema.removeField("amadv2m1")

  // remove
  collection.schema.removeField("4b3ryjes")

  // remove
  collection.schema.removeField("kzl6oajc")

  return dao.saveCollection(collection)
})
