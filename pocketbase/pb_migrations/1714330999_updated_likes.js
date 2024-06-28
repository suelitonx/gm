/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r3d8zrrbyc9tqe0")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "tnyozi6q",
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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r3d8zrrbyc9tqe0")

  // remove
  collection.schema.removeField("tnyozi6q")

  return dao.saveCollection(collection)
})
