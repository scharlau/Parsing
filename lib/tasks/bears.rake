require 'csv'
namespace :bears do
  desc "pull polar bear data into database"
  task seed_bears: :environment do

    #drop the old table data before importing the new stuff
    Deployment.destroy_all

    CSV.foreach("lib/assets/PolarBear_Telemetry_southernBeaufortSea_2009_2011/USGS_WC_eartag_deployments_2009-2011.csv", :headers =>true) do |row |
      puts row.inspect #just so that we know the file's being read

      #create new model instances with the data
      Deployment.create!(
      BearID: row[0].to_i,
      PTT_ID: row[1].to_i,
      capture_lat: row[6].to_d,
      capture_long: row[7].to_d,
      Sex: row[9],
      Age_class: row[10],
      Ear_applied: row[11]
    )
    end
  end

end
