# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!(name: 'Admin', email: 'admin@cafe-hub.com', password: 'aadmin', password_confirmation: 'aadmin', admin: true, sign_up_code: Setting.sign_up_code)
# userxx = User.create!(name: 'XX', email: 'xx@cafe-hub.com', password: 'xxxxxx', password_confirmation: 'xxxxxx', admin: false, sign_up_code: Setting.sign_up_code)