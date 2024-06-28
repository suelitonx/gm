/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l")

  collection.options = {
    "query": "SELECT a.id, a.jogo, a.created, b.name\nFROM likes AS a\nINNER JOIN users AS b\nON a.usuario = b.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "l86qfots",
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
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "hitouf6h",
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
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0m73a6un4ugn60l")

  collection.options = {
    "query": "SELECT id FROM likes"
  }

  // remove
  collection.schema.removeField("l86qfots")

  // remove
  collection.schema.removeField("hitouf6h")

  return dao.saveCollection(collection)
})
