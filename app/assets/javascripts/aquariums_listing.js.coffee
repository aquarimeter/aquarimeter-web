jQuery ->
  $('listitng.display').dataTable
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#listing.display').data('source')
      