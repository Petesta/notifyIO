json.extract! @organization, :name, :description
json.users @organization.users, :email
