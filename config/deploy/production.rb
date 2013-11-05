set :stage, :production

set :rvm_type, :user
set :rvm_ruby_version, '2.0.0-p247'

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
#
set :server_name, %w{ec2-54-211-109-234.compute-1.amazonaws.com}

role :app, fetch(:server_name)
role :web, fetch(:server_name)
role :db,  fetch(:server_name)
role :all,  fetch(:server_name)

set :ssh_options, {
  user: %(ubuntu),
  keys: %w(../NotifyIO-Keypair.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
}

set :rails_env, :production
fetch(:default_env).merge(rails_env: :production)

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a has can be used to set
# extended properties on the server.
#server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

# fetch(:default_env).merge!(rails_env: :production)