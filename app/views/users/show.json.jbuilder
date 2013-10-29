json.extract! @user, :email
json.organizations @user.organizations, :name, :description
