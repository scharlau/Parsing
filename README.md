# README FOR PARSING

This is a demonstrator app focusing on different ways to use Ruby to pull data from files and to dump it into your database as part of a Rails application. This application uses helper classes in Ruby for this, such as CSV class, and the JSON class, and as well as the fall-back of String methods with the File class.

We'll use this data on Polar bears in Alaska to develop our application
Data is taken from https://alaska.usgs.gov/products/data.php?dataid=130 Download the zip file and unpack it to a folder. This will give us more data than we need, but that's ok. We're only using it to learn how to import data.

Rails uses the 'lib' directory to store tasks that manipulate assets in an application. Put the unpacked zip folder 'PolarBear_Telemetry...' here. We will call the csv files later. We'll start with one file, and then look at how we can join the data from two different files to build more interesting pages.

With this we can start developing our application.

    rails new parsing

This will create our new app structure. We can now look at the USGS_WC_eartag_deployments_2009-2011.csv file and create some scaffolding to model and manipulate the data with the command

    rails generate scaffold deployments BearID:integer PTT_ID:integer capture_lat:decimal capture_long:decimal Sex Age_class Ear_applied

We are not using all of the columns that are here. We could use all of the data, but as we're not biologists, we'll only take what looks interesting to us. If we change our minds, then we write a migration to modify the database, and then edit the view and controllers files accordingly to make the changes. 

We need to run the migration to set up the database for us to import the data.

    rails db:migrate

## Do the Work 
Work through the three rounds with a partner, or on your own, depending upon your circumstances. Each round should be twelve minutes, followed by a discussion of where you are and what has been working, as well as, what you're working on next.

Now we need to get the polar bear data into our app. We have a number of options with which to do this. We'll start with the CVS class as our data is in this format.

1. Round one should be reading the csv file and getting the data into the application.
2. Round two should be displaying the data in a suitable manner.
3. Round three should be adding in the data in the 'status.cvs' file to tie together the bears with their current status. See the section further below for details on this part.

## Reading a CSV file
This is a common approach to working with open data, which is available in this format. There are methods available to read each row, and to parse them into objects for your application using http://ruby-doc.org/stdlib-2.5.2/libdoc/csv/rdoc/CSV.html You can also find more at https://www.sitepoint.com/guide-ruby-csv-library-part/

We can start with generating a seed file to move the data. We do that with the command

    rails g task bears seed_bears

This will create a file under lib/tasks/bears.rake which we can now modify to suit our needs.

Now, go look at the file here in the repo, and copy the code to your file, and you should find it runs ok. Run it with the command

    rake bears:seed_bears

Then start rails, and go look at http://localhost:3000/deployments to see your list of bears.

## Following Individual Bears
You could expand on this by parsing the USGS_WC_eartags_output_files_2009-2011-Status.csv file so that it uses the DeployID column to reference the BearID column in our original file. This will let us see the travels of each bear since it was tagged. Then you could use the geo-location data to plot these locations on a map.

Do this by coping lines 4-23 (the task seed_bears method) and pasting this into line 24 and giving it a new method name such as seed_status, and then changing the items you retrieve from each row in the file.

## The data is messy and the parsing will break

When you run this new method you will find the parsing breaks due to gaps in the data. It broke because one of the cells had no data, or had the data format different from what the parser was expecting. Given we're only doing this as an exercise, you can find the broken cell you can either a) delete the row, and then re-run the rake command, or b) write a few lines of code as an 'if/else' statement to check the value of the cell and to either ignore it, or do something else as required to make it work. For simplicity here, just delete the row and move on so that you get the file imported and the page views showing. You can see the start of this work if you switch to the 'solution' branch and look at the rake file there.

Then, you can go back to the views/deployments/show.index.html.erb file and bring in the relavant data from the status table to display here. Ideally, you could even plot the bear locations with a map. The key here is to modify the method under 'show' in the controll to query the 'status' table using the DeployID column to reference the BearID and then show this result on the page for each bear.

## This is rough and ready

This works, but also shows issues. For example, BearID 20414 appears twice in deployments. If you select the second one, then you have no connected sightings. If you pick the first one, then you have LOTS of sightings. 

From here you could show the locations of the sightings on a map using the GPS coordinates. You could also do a chart showing how many sightings there were for each bear by date. You could also do something with the other categories to produce visualisations to suit your needs.

##  TODO Reading a JSON file
Ruby works well with JSON, as does Rails so using the JSON class is easy. http://ruby-doc.org/stdlib-2.5.2/libdoc/json/rdoc/JSON.html

## TODO Reading a Text File
This approach uses the File class to open a regular text file and reads each line looking for the different components, which will make up the data in the application. http://ruby-doc.org/core-2.5.2/File.html
