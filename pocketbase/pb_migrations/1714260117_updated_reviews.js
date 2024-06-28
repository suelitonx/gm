/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("1w9rljmdr5hepbi")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_vjeqq87` ON `reviews` (\n  `usuario`,\n  `jogo`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("1w9rljmdr5hepbi")

  collection.indexes = []

  return dao.saveCollection(collection)
})
