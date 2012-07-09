set :user, "ubuntu"
server "174.129.27.35", :app, :web, :db, :primary => true
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/rails_app.pem"]
set :deploy_to, "/var/www/hype.am/production"