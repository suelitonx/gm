/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0jpqrjx1ufca3ce")

  collection.options = {
    "query": "SELECT \n  id, jogo,\n  COUNT(*) AS total_likes\nFROM likes\nWHERE valor = true\nGROUP BY jogo;"
  }

  // remove
  collection.schema.removeField("f2zze4zs")

  // remove
  collection.schema.removeField("rdszzsla")

  // remove
  collection.schema.removeField("sbsjhoi4")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fscntqsy",
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
    "id": "rk6aepyv",
    "name": "total_likes",
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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0jpqrjx1ufca3ce")

  collection.options = {
    "query": "SELECT \n  id, jogo, valor,\n  COUNT(*) AS total_likes\nFROM likes\nWHERE valor = true\nGROUP BY jogo;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "f2zze4zs",
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
    "id": "rdszzsla",
    "name": "valor",
    "type": "bool",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {}
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "sbsjhoi4",
    "name": "total_likes",
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

  // remove
  collection.schema.removeField("fscntqsy")

  // remove
  collection.schema.removeField("rk6aepyv")

  return dao.saveCollection(collection)
})
