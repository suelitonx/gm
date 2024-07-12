/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("dwjwxwu0qfbn8ht");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "dwjwxwu0qfbn8ht",
    "created": "2024-03-29 05:54:04.461Z",
    "updated": "2024-04-14 20:23:26.427Z",
    "name": "alunos",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "tazrzvvt",
        "name": "nome",
        "type": "text",
        "required": false,
        "presentable": true,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "dh2gzklm",
        "name": "codigo",
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
        "id": "dhwqvico",
        "name": "telefone",
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
        "id": "ecpjt4yr",
        "name": "turma",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "aoncf51a35lgrgz",
          "cascadeDelete": true,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "3rbkx2jm",
        "name": "cpf",
        "type": "text",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": "^\\d{3}\\.?\\d{3}\\.?\\d{3}-?\\d{2}$"
        }
      }
    ],
    "indexes": [],
    "listRule": "@request.auth.id != ''",
    "viewRule": "@request.auth.id != ''",
    "createRule": "@request.auth.id != ''",
    "updateRule": "@request.auth.id != ''",
    "deleteRule": "@request.auth.id != ''",
    "options": {}
  });

  return Dao(db).saveCollection(collection);
})
