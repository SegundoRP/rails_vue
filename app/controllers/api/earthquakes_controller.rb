class Api::EarthquakesController < ApplicationController
  def index
    @total = Earthquake.count
    @page =  (params[:page] || 1).to_i
    per_page = params[:per_page].to_i
    @per_page = per_page <= 1000 && per_page.positive? ? per_page : 1000

    render json: serializable_earthquakes.merge(pagination_hash), status: :ok
  end

  private

  def filtered_earthquakes
    mag_types = params[:mag_type] & Earthquake::VALID_FILTER_MAG_TYPES

    return Earthquake.all if !mag_types || mag_types.empty?

    Earthquake.where(mag_type: mag_types)
  end

  def pagination_hash
    { pagination: { current_page: @page, total: @total, per_page: @per_page } }
  end

  def earthquakes_paginated
    filtered_earthquakes.paginate(page: @page, per_page: @per_page)
  end

  def serializable_earthquakes
    EarthquakeSerializer.new(earthquakes_paginated, { is_collection: true }).serializable_hash
  end
end
