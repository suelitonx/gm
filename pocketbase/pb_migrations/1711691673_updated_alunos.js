/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("dwjwxwu0qfbn8ht")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ecpjt4yr",
    "name": "turma",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "aoncf51a35lgrgz",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("dwjwxwu0qfbn8ht")

  // remove
  collection.schema.removeField("ecpjt4yr")

  return dao.saveCollection(collection)
})
