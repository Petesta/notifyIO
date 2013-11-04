json.extract! @organization, :name, :description
json.users @organization.users, :email
json.notifications @organization.notifications, :id, :message, :notification_type
