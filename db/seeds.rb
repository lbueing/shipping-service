# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
package = ActiveShipping::Package.new(3*16, [6, 8, 10], units: :imperial)


origin = ActiveShipping::Location.create(
    country: 'US',
    state: 'WA',
    city: 'Seattle',
    zip: '98125')

destination = ActiveShipping::Location.create(
    country: 'US'
    state: 'KS'
    city: 'Topeka'
    zip: '66601')
