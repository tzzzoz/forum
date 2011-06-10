set :application, "dream"
set :repository,  "git@github.com:vvdpzz/dream.git"

set :scm, "git"
set :branch, "master"
set :user, "vvdpzz"
set :scm_passphrase, "930514"

role :web, "http://173.255.204.118"                     # Your HTTP server, Apache/etc
role :app, "http://173.255.204.118"                # This may be the same as your `Web` server
role :db,  "http://173.255.204.118", :primary => true   # This is where Rails migrations will run

set :deploy_to, "/var/app/#{application}"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end