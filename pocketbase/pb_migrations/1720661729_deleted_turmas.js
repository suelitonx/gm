/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("aoncf51a35lgrgz");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "aoncf51a35lgrgz",
    "created": "2024-03-29 05:54:17.692Z",
    "updated": "2024-03-30 03:32:18.422Z",
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
      },
      {
        "system": false,
        "id": "x3muq6b0",
        "name": "escola",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "kg8glbqmwpv2hco",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      }
    ],
    "indexes": [],
    "listRule": "",
    "viewRule": "",
    "createRule": "",
    "updateRule": "",
    "deleteRule": "",
    "options": {}
  });

  return Dao(db).saveCollection(collection);
})
