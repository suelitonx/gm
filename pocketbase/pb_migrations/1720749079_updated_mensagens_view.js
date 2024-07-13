/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("vn733gh7op5dcnq")

  collection.options = {
    "query": "SELECT\n    m.id,\n    m.usuario_enviou AS id_usuario_enviou,\n    m.usuario_recebeu AS id_usuario_recebeu,\n    ue.name AS nome_usuario_enviou,\n    ur.name AS nome_usuario_recebeu,\n    m.mensagem,\n    m.created\nFROM \n    mensagens m\nJOIN \n    users ue ON m.usuario_enviou = ue.id\nJOIN \n    users ur ON m.usuario_recebeu = ur.id;"
  }

  // remove
  collection.schema.removeField("kwwnwfuv")

  // remove
  collection.schema.removeField("6unjjk6j")

  // remove
  collection.schema.removeField("tyidinal")

  // remove
  collection.schema.removeField("nzl6cge7")

  // remove
  collection.schema.removeField("uttfjulm")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "30sfh0dy",
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
    "id": "kugmpted",
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
    "id": "brdgojju",
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
    "id": "9y7rwzsh",
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

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "dziudseq",
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
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("vn733gh7op5dcnq")

  collection.options = {
    "query": "SELECT\n    m.id,\n    m.usuario_enviou AS id_usuario_enviou,\n    m.usuario_recebeu AS id_usuario_recebeu,\n    ue.name AS nome_usuario_enviou,\n    ur.name AS nome_usuario_recebeu,\n    m.mensagem\nFROM \n    mensagens m\nJOIN \n    users ue ON m.usuario_enviou = ue.id\nJOIN \n    users ur ON m.usuario_recebeu = ur.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "kwwnwfuv",
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
    "id": "6unjjk6j",
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
    "id": "tyidinal",
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
    "id": "nzl6cge7",
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

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "uttfjulm",
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
  }))

  // remove
  collection.schema.removeField("30sfh0dy")

  // remove
  collection.schema.removeField("kugmpted")

  // remove
  collection.schema.removeField("brdgojju")

  // remove
  collection.schema.removeField("9y7rwzsh")

  // remove
  collection.schema.removeField("dziudseq")

  return dao.saveCollection(collection)
})
