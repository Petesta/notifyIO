namespace :seeds do
  COUNT = ENV['count'].to_i

  desc "TODO"
  task :users => :environment do
    COUNT = 100 if COUNT == 0

    if User.last.nil?
      LAST_USER_ID = 0
    else
      LAST_USER_ID = User.last.id
    end

    (LAST_USER_ID..COUNT+LAST_USER_ID).to_a.each do |n|
      u = User.create(email: "admin_#{n}@admin.com", password: 'adminadmin')
      puts "Created user #{n}!" if n%10 == 0

      #  user_id = n
      #  user_name = "admin_#{n}@admin.com"
      #  password = 'adminadmin'
      #  users << "(#{user_id}, '#{user_name}', '#{password}')"
    end
  end

  desc "TODO"
  task :organizations => :environment do
    COUNT = 75 if COUNT == 0

    if Organization.last.nil?
      LAST_ORG_ID = 0
    else
      LAST_ORG_ID = Organization.last.id
    end

    (LAST_ORG_ID..COUNT+LAST_ORG_ID).to_a.each do |n|
      o = Organization.create(name: "Organization #{n}", description: 'Fancy description of my organization')
      puts "Created organization #{n}!" if n%10 == 0
      o.users << User.all

      #  org_id = n
      #  org_name = "Organization #{n}"
      #  org_desc = 'Organization created from raw sql'
      #  orgs << "(#{org_id}, '#{org_name}', '#{org_desc}')"
    end
  end

  desc "TODO"
  task :notifications => :environment do
    COUNT = 100 if COUNT == 0
    notifications = []
    org_count = 0

    Organization.all.each do |org|
      (COUNT).times do |n|
        notifications << random_notification(org.id)
      end
      org_count += 1
      puts "Generated Notifications for organization #{org.id}"
    end

    sql_statment = "INSERT INTO notifications (`notification_type`, `message`, `organization_id`, `created_at`, `updated_at`) VALUES #{notifications.join(", ")}"
    ActiveRecord::Base.connection.execute(sql_statment)
  end

end

TIMESTAMP = DateTime.now
def random_notification(org_id)
  notification_type = ['error', 'alert', 'success'].shuffle.first
  notification_message = 'Notification from raw sql'

  "('#{notification_type}', '#{notification_message}', #{org_id}, '#{TIMESTAMP}', '#{TIMESTAMP}')"
end
