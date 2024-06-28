/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("aoncf51a35lgrgz")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "x3muq6b0",
    "name": "escola",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "kg8glbqmwpv2hco",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("aoncf51a35lgrgz")

  // remove
  collection.schema.removeField("x3muq6b0")

  return dao.saveCollection(collection)
})
