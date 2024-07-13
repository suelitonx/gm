/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zfokxy7dan592km")

  collection.createRule = "@request.auth.id = usuario_enviou.id"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zfokxy7dan592km")

  collection.createRule = ""

  return dao.saveCollection(collection)
})
