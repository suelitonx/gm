/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("uookfe1b4nq25cm")

  collection.listRule = "@request.auth.id = id_usuario_enviou.id || @request.auth.id = id_usuario_recebeu.id"
  collection.viewRule = "@request.auth.id = id_usuario_enviou.id || @request.auth.id = id_usuario_recebeu.id"

  // remove
  collection.schema.removeField("rqkvwiox")

  // remove
  collection.schema.removeField("vjublxmu")

  // remove
  collection.schema.removeField("i3n7g5nd")

  // remove
  collection.schema.removeField("ajq4baxy")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "j3jvjhkt",
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
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "3auyikxu",
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
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "bukgypyf",
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
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "2arpa0mu",
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
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("uookfe1b4nq25cm")

  collection.listRule = null
  collection.viewRule = null

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // remove
  collection.schema.removeField("j3jvjhkt")

  // remove
  collection.schema.removeField("3auyikxu")

  // remove
  collection.schema.removeField("bukgypyf")

  // remove
  collection.schema.removeField("2arpa0mu")

  return dao.saveCollection(collection)
})
