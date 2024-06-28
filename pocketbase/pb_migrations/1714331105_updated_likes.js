/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r3d8zrrbyc9tqe0")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_FnNqxqR` ON `likes` (\n  `usuario`,\n  `jogo`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r3d8zrrbyc9tqe0")

  collection.indexes = []

  return dao.saveCollection(collection)
})
