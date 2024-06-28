/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0jpqrjx1ufca3ce")

  collection.name = "total_likes"

  // remove
  collection.schema.removeField("wryn2cv0")

  // remove
  collection.schema.removeField("hrglnw9k")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "uhssdqgj",
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
    "id": "e151nghe",
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

  collection.name = "total"

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "wryn2cv0",
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
    "id": "hrglnw9k",
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
  collection.schema.removeField("uhssdqgj")

  // remove
  collection.schema.removeField("e151nghe")

  return dao.saveCollection(collection)
})
