/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "cf6c1eu1fnis14d",
    "created": "2024-04-27 20:23:11.593Z",
    "updated": "2024-04-27 20:23:11.593Z",
    "name": "reviewsjogos",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "pprlejec",
        "name": "jogo",
        "type": "number",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "noDecimal": false
        }
      },
      {
        "system": false,
        "id": "drkzflgm",
        "name": "usuario",
        "type": "relation",
        "required": true,
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
    "listRule": "",
    "viewRule": "",
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT a.id, a.jogo, a.usuario\nFROM reviews AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("cf6c1eu1fnis14d");

  return dao.deleteCollection(collection);
})
