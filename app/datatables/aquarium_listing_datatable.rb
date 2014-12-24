# helper class to serializing to JSON and pagination of listing gracefully.
# adapted from http://railscasts.com/episodes/340-datatables
# Most of this is straight-forward --
class AquariumListingDatatable
  delegate :params, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Aquarium.count,
        iTotalDisplayRecords: listing.total_entries,
        aaData: data
    }
  end

  private

  def data
    @listings.map do |listing|
      [listing.name, listing.ideal_temperature, listing.ideal_min_temp, listing.ideal_max_temp
      ]
    end
  end

  def listing
    @listing ||= fetch_readings
  end

  def fetch_aquariums
    @listing = Aquarium.find_by(:user => current_user).order("#{sort_column} #{sort_direction}")
    @listing = listing.page(page).per_page(per_page)
    @listing
  end



  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end