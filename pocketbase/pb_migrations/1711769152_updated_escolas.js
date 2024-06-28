/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kg8glbqmwpv2hco")

  collection.createRule = ""
  collection.updateRule = ""
  collection.deleteRule = ""

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kg8glbqmwpv2hco")

  collection.createRule = null
  collection.updateRule = "@request.auth.id != \"\" && @request.auth.tipo = 3 && @request.auth.escola = id"
  collection.deleteRule = null

  return dao.saveCollection(collection)
})
