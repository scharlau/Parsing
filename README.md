# PARSING FILES

This is a demonstrator app focusing on different ways to use Ruby to pull data from files and to dump it into your database as part of a Rails application. This application uses helper classes in Ruby for this, such as CSV class, and the JSON class, and as well as the fall-back of String methods with the File class.

The goal of 'deliberate practice' is to think about how you'd solve this challenge, and to work at developing code to make this work. There is no single 'correct' version of this code. The purpose of the exercise it become familiar with different ways of making the application work. You should explore how this simple application is done in Rails so that you understand how variables in controllers are show up in the views you see in the browser.

Under 'deliberate practice' we offer up the challenge, then think about options for developing a solution, and code for 12 minutes. After that we pause to discuss how people are approaching the problem, and what they're trying to do. This should be repeated three times and then wrapped up with time for people to express what they found most useful during the session. This should take an hour.

We'll use data on Polar bears in Alaska to develop our application
Data is taken from https://alaska.usgs.gov/products/data.php?dataid=130 Download the zip file and unpack it to a folder. This will give us more data than we need, but that's ok. We're only using it to learn how to import data.

We'll start by importing some of the data from the USGS_WC_eartag_deployments_2009-2011.csv file and create some scaffolding to model and manipulate the data to put it into the database. Then we'll import some of the data from the USGS_WC_eartags_output_files_2009-2011-Status.csv file. Thhe DeployID column in this file references the BearID column in our original file. This tracks sightings of each bear since it was tagged by providing geo-coordinates and other details of each sighting.

We are not using all of the columns that are here. We could use all of the data, but as we're not biologists, we'll only take what looks interesting to us. If we change our minds, then we write a migration to modify the database, and then edit the view and controllers files accordingly to make the changes. 

With this we can start developing our application.

    rails new parsing

This will create our new app structure. Rails uses the 'lib' directory to store tasks that manipulate assets in an application. Put the unpacked zip folder 'PolarBear_Telemetry...' here. We will call the csv files later. We'll start with one file, and then look at how we can join the data from two different files to build more interesting pages.
We can now look at generating the start of our application with the command

    rails generate scaffold deployments BearID:integer PTT_ID:integer capture_lat:decimal capture_long:decimal Sex Age_class Ear_applied

This command will create a controller, a model, and associated views for us. As we're also tying the model to a table, it will also generate a migration file to create a table in the database for us. We need to run the migration file to set up the database for us to import the data.

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

Now, go look at the same file in the repo, and copy the code to your file, and you should find it runs ok. Run it with the command

    rake bears:seed_bears

Then start rails with 'rails server', and go look at http://localhost:3000/deployments to see your list of bears.

## Following Individual Bears
You can expand on this by parsing the USGS_WC_eartags_output_files_2009-2011-Status.csv file. Now we can see the travels of each bear since it was tagged. Then you could use the geo-location data to plot these locations on a map.

We need to generate another model for the data in the status file.

    rails generate model status deployID:integer recieved:string latitude:decimal longitude:decimal temperature:decimal deployment:references

This will generate a 'status' model tied to a similar named table in the database, along with a migration file for us to run to create the table. We don't need a controller or views as we'll use the ones we have. Run the migration as before with 

    rails db:migrate

This will modify the db/schema.rb file to add the details of the table in our database. We're now ready to import the data from the csv file usig our rake file. To do that we need to write a new task.

Do this by coping lines 4-23 (the task seed_bears method from your rake file) and pasting this into line 24 and giving it a new method name such as seed_status, and then changing the items you retrieve from each row in the file so that the new names match the columns you want to use. You don't need all of them.

## The data is messy and the parsing will break

When you run this new method you will find the parsing breaks due to gaps in the data. It broke because one of the cells had no data, or had the data format different from what the parser was expecting. This is the nature of real-world data. It's not always nice and tidy.

Given we're only parsing this data as an exercise, you can find the broken cell, and then you can either a) delete the row, and then re-run the rake command, or b) write a few lines of code as an 'if/else' statement to check the value of the cell and to either ignore it, or do something else as required to make it work. For simplicity here, just delete the row and move on so that you get the file imported and the page views showing. You can see the start of this work if you switch to the 'solution' branch and look at the rake file there.

Then, you can go back to the views/deployments/show.index.html.erb file and bring in the relavant data from the status table to display here. The key here is to modify the method under 'show' in the controller to query the 'status' table using the DeployID column to reference the BearID and then show this result on the 'show' page for each bear.

## This is rough and ready

This works, but also shows issues. For example, BearID 20414 appears twice in deployments. If you select the second one, then you have no connected sightings. If you pick the first one, then you have LOTS of sightings. 

From here you could show the locations of the sightings on a map using the GPS coordinates. You could also do a chart showing how many sightings there were for each bear by date. You could also do something with the other categories to produce visualisations to suit your needs.

##  TODO Reading a JSON file
Ruby works well with JSON, as does Rails so using the JSON class is easy. http://ruby-doc.org/stdlib-2.5.2/libdoc/json/rdoc/JSON.html

## TODO Reading a Text File
This approach uses the File class to open a regular text file and reads each line looking for the different components, which will make up the data in the application. http://ruby-doc.org/core-2.5.2/File.html
