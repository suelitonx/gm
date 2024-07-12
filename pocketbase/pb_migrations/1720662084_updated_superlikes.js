/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("biahol2wpjh9tby")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_LpC2Za6` ON `superlikes` (\n  `usuario`,\n  `jogo`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("biahol2wpjh9tby")

  collection.indexes = []

  return dao.saveCollection(collection)
})
