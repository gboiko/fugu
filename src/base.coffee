di = require "fugu"
  
exports.a = ->
  db_work = di.require 'db_work'

  return db_work.loadData()

exports.b = ->
  return "original"


