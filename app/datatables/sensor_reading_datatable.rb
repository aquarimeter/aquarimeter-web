# helper class to serializing to JSON and pagination of readings gracefully.
# adapted from http://railscasts.com/episodes/340-datatables
# Most of this is straight-forward --
class SensorReadingDatatable
  delegate :params, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: SensorReading.count,
        iTotalDisplayRecords: readings.total_entries,
        aaData: data
    }
  end

  private

  def data
    readings.map do |readings|
      [
          (readings.created_at.strftime('%b %e %Y %H:%M:%S')),
          (readings.ph.to_f),
          (readings.temperature.to_f)
      ]
    end
  end

  def readings
    @readings ||= fetch_readings
  end

  def fetch_readings
    readings = SensorReading.order("#{sort_column} #{sort_direction}")
    readings = readings.page(page).per_page(per_page)
    readings
  end



  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[ph temperature created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end