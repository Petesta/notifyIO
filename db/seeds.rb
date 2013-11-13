# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
COUNT = 10000

(1..COUNT).to_a.each do |n|
	u = User.create(email: "admin_#{n}@admin.com", password: 'adminadmin')
	puts "Created user #{n}!" if n%10 == 0
end


# Organizations
(1..COUNT).to_a.each do |n|
	o = Organization.new(name: "Organization #{n}", description: 'Fancy description of my organization')
	puts "Created organization #{n}!" if n%10 == 0
	o.users << User.all
end


# Notifications
def random_notification
  notification_type = ['error', 'alert', 'success'].shuffle.first
  Notification.create(notification_type: notification_type, message: 'Test message for seed data.')
end

Organization.all.each do |org|
  COUNT.times do
    org.notifications << random_notification
    puts "Created Notification for organization #{org.id}"
  end
end

