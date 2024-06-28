/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "aoncf51a35lgrgz",
    "created": "2024-03-29 05:54:17.692Z",
    "updated": "2024-03-29 05:54:17.692Z",
    "name": "turmas",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "lhehtmug",
        "name": "nome",
        "type": "text",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("aoncf51a35lgrgz");

  return dao.deleteCollection(collection);
})
