jQuery ->
  $('#readings').dataTable
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#readings.display').data('source')

jQuery ->
  Morris.Line
  alert("JINGYYYYY");
  element: '#readings_chart'
  data: $("#reading_chart").data('readings')
  xkey: 'created_at'
  ykeys: ['ph', 'temperature']
  labels: ['pH', 'temperature']
  preUnits: '&deg;'
