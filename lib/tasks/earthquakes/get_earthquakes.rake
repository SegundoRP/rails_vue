namespace :earthquakes do
  desc 'Get earthquakes for the last 30 days from USGS external API'
  task get_earthquakes: :environment do
    CreateEarthquakes.new.execute
  end
end
