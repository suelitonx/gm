/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("jt4pijzlj5p0gdd")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "506rfjbl",
    "name": "p_relacao_multipla",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "_pb_users_auth_",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("jt4pijzlj5p0gdd")

  // remove
  collection.schema.removeField("506rfjbl")

  return dao.saveCollection(collection)
})
