/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "0m73a6un4ugn60l",
    "created": "2024-04-27 23:35:55.619Z",
    "updated": "2024-04-27 23:35:55.619Z",
    "name": "likes_view",
    "type": "view",
    "system": false,
    "schema": [],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT id FROM likes"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l");

  return dao.deleteCollection(collection);
})
