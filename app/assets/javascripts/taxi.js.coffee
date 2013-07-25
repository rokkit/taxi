window.Taxi =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> #alert 'Hello from Backbone!'
    new Taxi.Routers.Entries()
    Backbone.history.start()

$(document).ready ->
  Taxi.initialize()
