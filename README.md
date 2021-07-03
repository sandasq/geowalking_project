# README

Installation and Running:

budle install

rails db:migrate

rails db:seed

rails server

http://localhost:3000/walks

Relevant Files - all others are skelton Rails:

CSV file:
The csvfile is being read from db/seeds.rb

The trigger url goes throgh the app/controllers/walks_controller.rb which calls the service app/services/geo_walk_creator.rb.  The service has the bulk of the work of finding the individuals walks and calculating the distance, duration and average speed.

DB model files:

app/models/geo_datum.db

app/models/walk.db

Helper used for display:

app/helpers/walks_helper.rb

View:

app/views/walks/index.html.erb

NOTE: the Geocoder gem might be a good solution for this type of data but was not used in this project: https://www.rubydoc.info/gems/rails-geocoder/0.9.11/Geocoder
