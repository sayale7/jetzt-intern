set :application, "jetzt_intern"
set :deploy_to, "/var/rails/#{application}"
#############################################################
# Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, true

#############################################################
# Servers
#############################################################

set :user, "root"
set :domain, "83.169.34.180"
server domain, :app, :web
role :db, domain, :primary => true
set :runner, "root"

#############################################################
# GIT
#############################################################

# set :repository,  "svn://kohler-it.net/jetzt/trunk/"
# set :svn_username, "thomas"
# set :svn_password, "aplhma6"
# set :checkout, "export"

set :scm, "git"
set :repository, "git://github.com:sayale7/jetzt-intern.git"
set :branch, "master"

after "deploy:symlink", "deploy:update_crontab"

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

#############################################################
# Passenger
#############################################################

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

    [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

