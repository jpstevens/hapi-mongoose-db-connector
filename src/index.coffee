_ = require 'underscore'
Hoek = require "hoek"
mongoose = require 'mongoose'

Mixed = mongoose.Schema.Types.Mixed
ObjectId = mongoose.Schema.Types.ObjectId

module.exports.register = (plugin, options = {}, cb) ->
  defaults =
    mongodbUrl: null

  options = Hoek.applyToDefaults defaults, options

  Hoek.assert(options.mongodbUrl, 'Missing required mongodbUrl property in fanignite-store configuration');


  startDb = ->
    plugin.log ['plugin', 'info'], "Mongoose connecting to #{options.mongodbUrl}"
    mongoose.connect options.mongodbUrl, (err) ->
      if err
        plugin.log ['plugin', 'error','fatal'], "Mongoose connection failure"
      else
        plugin.log ['plugin', 'info'], "Mongoose connected to #{options.mongodbUrl}"

  stopDb = ->
    # @TODO: Implement this correctly.
  
  startDb()

  plugin.expose 'mongoose', mongoose
  plugin.expose 'mongooseStartDb',startDb 
  plugin.expose 'mongooseStopDb',stopDb

  cb()

module.exports.register.attributes =
    pkg: require '../package.json'