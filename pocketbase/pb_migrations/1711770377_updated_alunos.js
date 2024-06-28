/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("dwjwxwu0qfbn8ht")

  // remove
  collection.schema.removeField("oa9iwdsr")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("dwjwxwu0qfbn8ht")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "oa9iwdsr",
    "name": "cpf",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": true
    }
  }))

  return dao.saveCollection(collection)
})
