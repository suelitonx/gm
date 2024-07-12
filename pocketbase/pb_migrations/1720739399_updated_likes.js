/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r3d8zrrbyc9tqe0")

  collection.deleteRule = null

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r3d8zrrbyc9tqe0")

  collection.deleteRule = ""

  return dao.saveCollection(collection)
})
