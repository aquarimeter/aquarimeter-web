jQuery ->
  Morris.Line
    element: '.graph-placeholder'
    data: ""
    xkey: 'created_at'
    ykeys: ['ph','temperature']
    labels: ['pH','temperature']
    preUnits: '&deg;'