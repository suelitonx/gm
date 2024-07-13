/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "uookfe1b4nq25cm",
    "created": "2024-07-12 21:50:00.183Z",
    "updated": "2024-07-12 21:50:00.183Z",
    "name": "msgview",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "rqkvwiox",
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
        "id": "vjublxmu",
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
        "id": "i3n7g5nd",
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
        "id": "ajq4baxy",
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
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT\n    m1.id,\n    m1.usuario_enviou AS id_usuario_enviou,\n    m1.usuario_recebeu AS id_usuario_recebeu,\n    ue.name AS nome_usuario_enviou,\n    ur.name AS nome_usuario_recebeu\nFROM \n    mensagens m1\nINNER JOIN \n    users ue ON m1.usuario_enviou = ue.id\nINNER JOIN \n    users ur ON m1.usuario_recebeu = ur.id\nWHERE \n    m1.id = (\n        SELECT \n            MIN(m2.id)\n        FROM \n            mensagens m2\n        WHERE \n            (m2.usuario_enviou = m1.usuario_enviou AND m2.usuario_recebeu = m1.usuario_recebeu)\n            OR\n            (m2.usuario_enviou = m1.usuario_recebeu AND m2.usuario_recebeu = m1.usuario_enviou)\n    )\nORDER BY \n    id_usuario_enviou, id_usuario_recebeu;"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("uookfe1b4nq25cm");

  return dao.deleteCollection(collection);
})
