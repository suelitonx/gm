/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("vn733gh7op5dcnq")

  collection.listRule = ""
  collection.viewRule = ""

  // remove
  collection.schema.removeField("zedgpp5g")

  // remove
  collection.schema.removeField("n0zuncl1")

  // remove
  collection.schema.removeField("bdqjyczv")

  // remove
  collection.schema.removeField("ked2lwta")

  // remove
  collection.schema.removeField("58fzhovp")

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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("vn733gh7op5dcnq")

  collection.listRule = null
  collection.viewRule = null

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

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

  return dao.saveCollection(collection)
})
