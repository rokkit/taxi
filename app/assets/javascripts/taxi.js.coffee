$.datepicker.setDefaults({
     dateFormat: 'dd.mm.yy'
})

$(document).ready ->
  # $("#trip_date").pickadate
  #   monthsFull: ['Январь', 'February', 'March', 'April', 'May', 'June', 'Июль', 'Август', 'September', 'October', 'November', 'December']
  #   monthsShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  #   weekdaysFull: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  #   weekdaysShort: ['Вск', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб']
  #   showMonthsShort: false
  #   showWeekdaysFull: false
  #   firstDay: "Пон"
  #   today: 'Сегодня',
  #   clear: 'Сброс',
  # $("#trip_time").pickatime()
  $('#trip_user_id').on 'railsAutocomplete.select', (event, data) ->
    console.log "au"
  $('.datatable').dataTable
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

jQuery ->  
   $('#trips-table').dataTable(
      bProcessing: true
      bServerSide: true
      sAjaxSource: $('#trips-table').data('source')
      bLengthChange: false
      aoColumnDefs: [{bSortable: false, aTargets:[2, 6]}]
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
    ).columnFilter 
          # sPlaceHolder: "head:after"
          aoColumns: [
                        {type: "date-range" }, {type: "date-range" }, null, null, null, null, null, null
                      ]




