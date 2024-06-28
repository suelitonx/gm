/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("1w9rljmdr5hepbi")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "nc6dpldq",
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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("1w9rljmdr5hepbi")

  // remove
  collection.schema.removeField("nc6dpldq")

  return dao.saveCollection(collection)
})
