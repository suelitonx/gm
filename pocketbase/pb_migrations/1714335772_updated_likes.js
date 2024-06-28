/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r3d8zrrbyc9tqe0")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "sj8zimmm",
    "name": "valor",
    "type": "bool",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {}
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r3d8zrrbyc9tqe0")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "sj8zimmm",
    "name": "valor",
    "type": "bool",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {}
  }))

  return dao.saveCollection(collection)
})
