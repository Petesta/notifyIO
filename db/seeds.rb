# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
COUNT = 100
NOTIFICATIONS_PER_ORG = 1000
users = []
orgs = []
subs = []
notifications = []

# We're just going to use the same timestamp for all notifications to save the time of generating one each notification.
TIMESTAMP = DateTime.now
puts "Users:"
(1..COUNT).to_a.each do |n|
  u = User.create(email: "admin_#{n}@admin.com", password: 'adminadmin')
  puts "Created user #{n}!" if n%10 == 0

#  user_id = n
#  user_name = "admin_#{n}@admin.com"
#  password = 'adminadmin'
#  users << "(#{user_id}, '#{user_name}', '#{password}')"
end


puts "Orgs:"
# Organizations
(1..COUNT).to_a.each do |n|
#  o = Organization.create(name: "Organization #{n}", description: 'Fancy description of my organization')
#  puts "Created organization #{n}!" if n%10 == 0
#  o.users << User.all
  
  org_id = n 
  org_name = "Organization #{n}"
  org_desc = 'Organization created from raw sql'
  orgs << "(#{org_id}, '#{org_name}', '#{org_desc}', '#{TIMESTAMP}', '#{TIMESTAMP}', 'abcdef')"

end

sql_orgs = "INSERT INTO organizations (`id`, `name`, `description`, `created_at`, `updated_at`, `api_key`) VALUES #{orgs.join(", ")}"
ActiveRecord::Base.connection.execute(sql_orgs)


puts "Subs:"
# Now we want to add all of the users to the organizations
(1..COUNT).to_a.each do |n|
  (1..COUNT).to_a.each do |m|
    subs << "(#{n}, #{m}, '#{TIMESTAMP}', '#{TIMESTAMP}')"
  end
end

sql_subs = "INSERT INTO subscriptions (`organization_id`, `user_id`, `created_at`, `updated_at`) VALUES #{subs.join(", ")}"
#puts sql_subs
ActiveRecord::Base.connection.execute(sql_subs)


puts "Notifications:"
# Notifications
def random_notification(id, org_id)
  notification_type = ['error', 'alert', 'success'].shuffle.first
  #Notification.create(notification_type: notification_type, message: 'Test message for seed data.')

  notification_message = 'Notification from raw sql'

# Rewire the cat 32 cable to sql inject the mainframe
  notification_message += ' ...oooh you touched my tralala' if id%100 == 0
# ----

  "(#{id}, '#{notification_type}', '#{notification_message}', #{org_id}, '#{TIMESTAMP}', '#{TIMESTAMP}')"
end


org_count = 0
i_id = 1
Organization.all.each do |org|
#    puts "Generated Notification for organization #{org.id}"
  (NOTIFICATIONS_PER_ORG).times do |n|
    notifications << random_notification(i_id, org.id)
    i_id += 1
  end
  org_count += 1
  puts "Generated Notifications for organization #{org.id}"
end
#puts users
#puts orgs
#puts notifications

sql_statement = "INSERT INTO notifications (`id`, `notification_type`, `message`, `organization_id`, `created_at`, `updated_at`) VALUES #{notifications.join(", ")}"
#puts sql_statment

ActiveRecord::Base.connection.execute(sql_statement)
