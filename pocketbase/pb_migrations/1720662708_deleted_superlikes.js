/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("biahol2wpjh9tby");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "biahol2wpjh9tby",
    "created": "2024-07-11 01:36:39.825Z",
    "updated": "2024-07-11 01:41:24.114Z",
    "name": "superlikes",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "beyxj1nq",
        "name": "usuario",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "_pb_users_auth_",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "gtlkbgln",
        "name": "jogo",
        "type": "number",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "noDecimal": false
        }
      }
    ],
    "indexes": [
      "CREATE UNIQUE INDEX `idx_LpC2Za6` ON `superlikes` (\n  `usuario`,\n  `jogo`\n)"
    ],
    "listRule": "",
    "viewRule": "",
    "createRule": "",
    "updateRule": "",
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
})
