# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach('lib/seeds/gps_dataset.csv', headers: true, encoding: 'ISO-8859-1', col_sep: ';') do |row|
    t = GeoDatum.create(row.to_h)
    puts "#{t.timestamp} saved"
end

puts "There are now #{GeoDatum.count} rows in the table"
