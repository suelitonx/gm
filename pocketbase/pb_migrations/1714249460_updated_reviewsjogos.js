/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("cf6c1eu1fnis14d")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.avaliacao, a.usuario\nFROM reviews AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // remove
  collection.schema.removeField("pprlejec")

  // remove
  collection.schema.removeField("drkzflgm")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "5a2xnvhr",
    "name": "jogo",
    "type": "number",
    "required": true,
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
    "id": "ag03ohab",
    "name": "avaliacao",
    "type": "number",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "min": 1,
      "max": 5,
      "noDecimal": false
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ghshx1d9",
    "name": "usuario",
    "type": "relation",
    "required": true,
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
  const collection = dao.findCollectionByNameOrId("cf6c1eu1fnis14d")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.usuario\nFROM reviews AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "pprlejec",
    "name": "jogo",
    "type": "number",
    "required": true,
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
    "id": "drkzflgm",
    "name": "usuario",
    "type": "relation",
    "required": true,
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

  // remove
  collection.schema.removeField("5a2xnvhr")

  // remove
  collection.schema.removeField("ag03ohab")

  // remove
  collection.schema.removeField("ghshx1d9")

  return dao.saveCollection(collection)
})