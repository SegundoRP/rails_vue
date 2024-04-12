namespace :earthquakes do
  desc 'Get earthquakes for the last 30 days from USGS external API'
  task get_earthquakes: :environment do
    UsgsClient.new.earthquakes_last_month
  end
end
