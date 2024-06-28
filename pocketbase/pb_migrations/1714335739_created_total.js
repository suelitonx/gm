/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "0jpqrjx1ufca3ce",
    "created": "2024-04-28 20:22:19.807Z",
    "updated": "2024-04-28 20:22:19.807Z",
    "name": "total",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "wryn2cv0",
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
      },
      {
        "system": false,
        "id": "hrglnw9k",
        "name": "total_likes",
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
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT \n  id, jogo,\n  COUNT(*) AS total_likes\nFROM likes\nGROUP BY jogo;"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("0jpqrjx1ufca3ce");

  return dao.deleteCollection(collection);
})
