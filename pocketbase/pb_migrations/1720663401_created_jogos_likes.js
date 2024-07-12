/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "hpscgpnkos9a60w",
    "created": "2024-07-11 02:03:21.431Z",
    "updated": "2024-07-11 02:03:21.431Z",
    "name": "jogos_likes",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "7i80fwnw",
        "name": "name",
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
        "id": "i1stxshb",
        "name": "liked_games",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT b.id, b.name, GROUP_CONCAT(a.id, ',') AS liked_games\nFROM likes AS a\nINNER JOIN users AS b ON (a.usuario = b.id AND a.valor = 1)\nGROUP BY b.name;\n"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("hpscgpnkos9a60w");

  return dao.deleteCollection(collection);
})
