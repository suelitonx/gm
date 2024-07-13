/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "vn733gh7op5dcnq",
    "created": "2024-07-12 01:48:25.926Z",
    "updated": "2024-07-12 01:48:25.926Z",
    "name": "mensagens_view",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "zedgpp5g",
        "name": "id_usuario_enviou",
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
        "id": "n0zuncl1",
        "name": "id_usuario_recebeu",
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
        "id": "bdqjyczv",
        "name": "nome_usuario_enviou",
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
        "id": "ked2lwta",
        "name": "nome_usuario_recebeu",
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
        "id": "58fzhovp",
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
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT\n    m.id,\n    m.usuario_enviou AS id_usuario_enviou,\n    m.usuario_recebeu AS id_usuario_recebeu,\n    ue.name AS nome_usuario_enviou,\n    ur.name AS nome_usuario_recebeu,\n    m.mensagem\nFROM \n    mensagens m\nJOIN \n    users ue ON m.usuario_enviou = ue.id\nJOIN \n    users ur ON m.usuario_recebeu = ur.id;"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("vn733gh7op5dcnq");

  return dao.deleteCollection(collection);
})
