# README FOR PARSING

This is a demonstrator app focusing on different ways to use Ruby to pull data from files and to dump it into your database as part of a Rails application. This application uses helper classes in Ruby for this, such as CSV class, and the JSON class, and as well as the fall-back of String methods with the File class.

We'll use this data on Polar bears in Alasks to develop our application
Data taken from https://alaska.usgs.gov/products/data.php?dataid=130 Download the zip file and unpack it to a folder.

With this we can start developing our application.

    rails new parsing

This will create our new app structure. We can now look at the csv file and create some scaffolding to model and manipulate the data with the command

    bin/rails generate scaffold deployments BearID:integer PTT_ID:integer capture_lat:decimal capture_long:decimal Sex Age_class Ear_applied

We could use all of the data, but as we're not biologists, we'll only take what looks interesting to us. If we change our minds, then we write a migration to modify the database, and then edit the view and controllers files accordingly to make the changes. It's a bit of work, but easier than seeking to remove the scaffolding, and starting over.

We need to run the migration to set up the database.

    rails db:migrate

Now we need to get the polar bear data into our app. We have a number of options with which to do this. We'll start with the CVS class as our data is in this format.

## Reading a CSV file
This is a common approach to working with open data, which is available in this format. There are methods available to read each row, and to parse them into objects for your application using http://ruby-doc.org/stdlib-2.4.2/libdoc/csv/rdoc/CSV.html You can also find more at https://www.sitepoint.com/guide-ruby-csv-library-part/

We can start with generating a seed file to move the data. We do that with the command

    rails g task bears seed_bears

This will create a file under lib/tasks/bears.rake which we can now modify to suit our needs.

Now, go look at the file here in the repo, and copy the code to your file, and you should find it runs ok. Run it with the command

    rake bears:seed_bears

Then start rails, and go look at http://localhost:3000/deployments to see your list of bears.

You could expand on this by parsing the status file so that it uses the DeployID column to reference the BearID column in our original file. This will let us see where the bears go. Then you could use the geo-location data to plot their locations on a map.


##  TODO Reading a JSON file
Ruby works well with JSON, as does Rails so using the JSON class is easy. http://ruby-doc.org/stdlib-2.4.2/libdoc/json/rdoc/JSON.html

## TODO Reading a Text File
This approach uses the File class to open a regular text file and reads each line looking for the different components, which will make up the data in the application. http://ruby-doc.org/core-2.4.2/File.html
