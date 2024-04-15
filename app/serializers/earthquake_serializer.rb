class EarthquakeSerializer
  include JSONAPI::Serializer
  set_type :feature
  attributes :external_id, :magnitude, :place, :time, :tsunami, :mag_type, :title
  link :external_url

  attribute :coordinates do |object|
    { longitude: object.longitude, latitude: object.latitude }
  end
end
