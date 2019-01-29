require 'csv'
namespace :bears do
  desc "pull polar bear data into database"
  task seed_bears: :environment do

    #drop the old table data before importing the new stuff
    Status.destroy_all
    Deployment.destroy_all

    p "tables emptied"

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

    CSV.foreach("lib/assets/PolarBear_Telemetry_southernBeaufortSea_2009_2011/USGS_WC_eartags_output_files_2009-2011-Status.csv", :headers =>true) do |row|
# this will break where DeployID includes (1) you could pull this string out
# strip off the (1) from the ID or skip the row.


      puts row.inspect #just so that we know the file's being read
      temp_temp = 0
      temp_bear_id = 0
      if row[4] != nil
        if row[9] != nil
          temp_temp = row[9].to_d
        else
          temp_temp = 0 # this works but not if we want to be correct
        end

        bear_temp = row[0]
        puts "bear_temp: " + bear_temp


        puts "bear_temp: " + bear_temp
        bear = Deployment.where(["BearID = ?", bear_temp])
        puts "size: " + bear.size.to_s
        bear = bear[0]
        puts "bear: " + bear.id.to_s
        Status.create!(
        deployment_id: bear.id,
        deployID: bear_temp.to_i,
        recieved: row[2].to_s,
        latitude: row[4].to_d,
        longitude: row[5].to_d,
        temperature: temp_temp
        )
      else
        puts "skip line"
      end
    end

  end

end
