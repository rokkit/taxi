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
  $('.table').dataTable
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    "sPaginationType": "bootstrap"
    oLanguage:
      sProcessing: "Подождите..."
      sLengthMenu: "Показать _MENU_ записей"
      sZeroRecords: "Записи отсутствуют."
      sInfo: "Записи с _START_ до _END_ из _TOTAL_ записей"
      sInfoEmpty: "Записи с 0 до 0 из 0 записей"
      sInfoFiltered: "(отфильтровано из _MAX_ записей)"
      sInfoPostFix: ""
      sSearch: "Поиск:"
      sUrl: ""
      oPaginate:
        sFirst: "Первая"
        sPrevious: "Предыдущая"
        sNext: "Следующая"
        sLast: "Последняя"
      oAria:
        sSortAscending: ": активировать для сортировки столбца по возрастанию"
        sSortDescending: ": активировать для сортировки столбцов по убыванию"

  #$('.nav-list li').click ->
    #$('nav-list li').removeClass("active")
    #$(this).addClass("active")




