jQuery ->
  Morris.Line
    element: 'orders_chart'
    data: $('.graph-placeholder').data(jQuery.getJSON('/api/v1/aquarium/1/reading'))
    xkey: created_at
    ykeys: ['ph','temperature']
    labels: ['pH','temperature']
    preUnits: '&deg;'