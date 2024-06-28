/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("cf6c1eu1fnis14d")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.avaliacao, b.name\nFROM reviews AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // remove
  collection.schema.removeField("8ao1kqbl")

  // remove
  collection.schema.removeField("u2e9g2au")

  // remove
  collection.schema.removeField("eto2ozga")

  // remove
  collection.schema.removeField("hx3zsgae")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "mgabydnv",
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
    "id": "mpqftrbd",
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
    "id": "bxwqxaey",
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
  const collection = dao.findCollectionByNameOrId("cf6c1eu1fnis14d")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.avaliacao, b.name, b.id as nome_usuario\nFROM reviews AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "8ao1kqbl",
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
    "id": "u2e9g2au",
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
    "id": "eto2ozga",
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
    "id": "hx3zsgae",
    "name": "nome_usuario",
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

  // remove
  collection.schema.removeField("mgabydnv")

  // remove
  collection.schema.removeField("mpqftrbd")

  // remove
  collection.schema.removeField("bxwqxaey")

  return dao.saveCollection(collection)
})
