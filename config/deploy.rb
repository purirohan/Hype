require "bundler/capistrano"
require "rvm/capistrano"                               # Load RVM's capistrano plugin.

set :stages, %w(production staging)
set :default_stage, "production"
require 'capistrano/ext/multistage'
set :application, "hype"
set :repository, "git@github.com:purirohan/Hype.git"
set :scm, :git
# ssh_options[:user] = "ubuntu"
# ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/keys/rails_app.pem"]

desc "check production task"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :deploy do
  namespace :assets do
    desc "Precompile assets on local machine and upload them to the server."
    task :precompile, roles: :web, except: {no_release: true} do
      run_locally "bundle exec rake assets:precompile --trace"
      find_servers_for_task(current_task).each do |server|
        run_locally "rsync -e 'ssh -i #{ENV['HOME']}/.ssh/keys/rails_app.pem' -vr --exclude='.DS_Store' public/assets #{user}@#{server.host}:#{shared_path}/"
      end
    end
  end
  
  namespace :db do
    desc "Run rake db:setup."
    task :setup, :roles => :db, :only => { :primary => true } do
        rake = fetch(:rake, "rake")
        rails_env = fetch(:rails_env, "production")
        migrate_env = fetch(:migrate_env, "")
        migrate_target = fetch(:migrate_target, :latest)

        directory = case migrate_target.to_sym
          when :current then current_path
          when :latest  then latest_release
          else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
          end

        run "cd #{directory} && #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:setup --trace"
      end
  end
end

# desc "Symlinks the database.yml"
# task :copy_db_file, :roles => :app do
#   #run "#{try_sudo} ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
#   find_servers_for_task(current_task).each do |server|
#     run_locally "rsync -e 'ssh -i #{ENV['HOME']}/.ssh/keys/rails_app.pem' -vr --exclude='.DS_Store' config/database.config.yml #{user}@#{server.host}:#{release_path}/config/database.yml"
#   end
# end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

# after "deploy:update", "copy_db_file"
#before "deploy", 'rvm:install_rvm', "rvm:trust_rvmrc"
after "deploy:restart", "deploy:cleanup"#, 'deploy:symlink_db'
