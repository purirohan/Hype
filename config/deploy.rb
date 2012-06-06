require "bundler/capistrano"
load 'deploy/assets'

set :application, "hype.am"
set :repository,  "https://github.com/purirohan/Hype.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "hype.am"                          # Your HTTP server, Apache/etc
role :app, "hype.am"                          # This may be the same as your `Web` server
role :db,  "hyep.am", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

set :deploy_to, "/var/www/hype.am/current/public"
# set :rails_env, 'production'
set :rails_env, 'staging'

set :use_sudo , true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
