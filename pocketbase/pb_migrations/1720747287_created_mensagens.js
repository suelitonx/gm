/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "zfokxy7dan592km",
    "created": "2024-07-12 01:21:27.415Z",
    "updated": "2024-07-12 01:21:27.415Z",
    "name": "mensagens",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "gwmnwrcb",
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
        "id": "aderfnkk",
        "name": "mensagem",
        "type": "text",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "min": 1,
          "max": 300,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "xnhzeiv7",
        "name": "destinatario",
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
  const collection = dao.findCollectionByNameOrId("zfokxy7dan592km");

  return dao.deleteCollection(collection);
})
