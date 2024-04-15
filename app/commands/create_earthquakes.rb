class CreateEarthquakes
  def execute
    process_response_batch
  rescue StandardError => e
    Rails.logger.error "Error processing earthquake data: #{e.message} #{e.backtrace}"
  end

  private

  def usgs_client
    @usgs_client ||= UsgsClient.new
  end

  def earthquake_api_response
    @earthquake_api_response ||= usgs_client.last_thirty_days_of_earthquakes['features']
  end

  def process_response_batch
    earthquake_api_response.each_slice(1000) do |batch|
      create_earthquake_records(batch)
    end
    nil
  end

  def create_earthquake_records(batch)
    batch.each do |feature|
      earthquake = build_earthquake_records(feature)
      next unless earthquake.valid?

      earthquake.save!
    end
  end

  def build_earthquake_records(feature)
    properties_hash = feature['properties']
    coordinates_hash = feature['geometry']
    Earthquake.build(assemble_earthquake_data(feature, properties_hash, coordinates_hash))
  end

  def assemble_earthquake_data(feature, properties_hash, coordinates_hash)
    feature_earthquake_data(feature).merge(properties_earthquake_data(properties_hash),
                                           coordinates_earthquake_data(coordinates_hash))
  end

  def feature_earthquake_data(feature)
    { external_id: feature['id'] }
  end

  def properties_earthquake_data(properties_hash)
    { magnitude: properties_hash['mag'], place: properties_hash['place'],
      time: properties_hash['time'], tsunami: properties_hash['tsunami'],
      mag_type: properties_hash['magType'], title: properties_hash['title'],
      external_url: properties_hash['url'] }
  end

  def coordinates_earthquake_data(coordinates_hash)
    { longitude: coordinates_hash['coordinates'][0],
      latitude: coordinates_hash['coordinates'][1] }
  end
end
