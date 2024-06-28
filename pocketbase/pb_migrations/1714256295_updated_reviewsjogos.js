/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("cf6c1eu1fnis14d")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.avaliacao, a.comentario, b.name, a.created\nFROM reviews AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // remove
  collection.schema.removeField("a4fgc1ob")

  // remove
  collection.schema.removeField("s0vadd2u")

  // remove
  collection.schema.removeField("bxiiebby")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "4fbd8tiv",
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
    "id": "djstwtqn",
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
    "id": "k5iktmdj",
    "name": "comentario",
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
    "id": "mvoatslj",
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
    "query": "SELECT a.id, a.jogo, a.avaliacao, b.name, a.created\nFROM reviews AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "a4fgc1ob",
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
    "id": "s0vadd2u",
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
    "id": "bxiiebby",
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
  collection.schema.removeField("4fbd8tiv")

  // remove
  collection.schema.removeField("djstwtqn")

  // remove
  collection.schema.removeField("k5iktmdj")

  // remove
  collection.schema.removeField("mvoatslj")

  return dao.saveCollection(collection)
})
