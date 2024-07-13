/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zfokxy7dan592km")

  collection.listRule = "@request.auth.id = usuario_enviou || @request.auth.id = usuario_recebeu"
  collection.viewRule = "@request.auth.id = usuario_enviou || @request.auth.id = usuario_recebeu"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zfokxy7dan592km")

  collection.listRule = ""
  collection.viewRule = ""

  return dao.saveCollection(collection)
})
