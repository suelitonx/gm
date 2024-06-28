/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("jt4pijzlj5p0gdd")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "rfslltsx",
    "name": "descricao",
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
  const collection = dao.findCollectionByNameOrId("jt4pijzlj5p0gdd")

  // remove
  collection.schema.removeField("rfslltsx")

  return dao.saveCollection(collection)
})
