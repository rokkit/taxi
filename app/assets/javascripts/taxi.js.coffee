window.Taxi =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> #alert 'Hello from Backbone!'

$(document).ready ->
  $("#trip_date").pickadate()
  $("#trip_time").pickatime()
  $('#trip_user_id').on 'railsAutocomplete.select', (event, data) ->
    console.log "au"




