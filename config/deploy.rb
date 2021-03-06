set :application, "optimiere.com"
role :app, application
role :web, application
role :db,  application, :primary => true

set :user, "optimiere"
set :deploy_to, "/var/rails/optimiere"
set :deploy_via, :remote_cache
set :use_sudo, false
set :port, '10022'

set :scm, "git"
set :repository,  "git://github.com/riethmayer/website.git"
set :branch, "master"

namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/3rd_party_apps.yml #{release_path}/config/3rd_party_apps.yml"
    run "ln -nfs #{shared_path}/config/3rd_party_apps.yml #{release_path}/config/3rd_party_apps.yml"
    run "ln -nfs #{shared_path}/config/disqus.yml #{release_path}/config/disqus.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
  
  desc "overwrite start, as we use passenger"
  task :start do
    # nothing
  end
  
  desc "Sync the public/asets directory."
  task :assets do
    system "rsync -vr --port=10022 --exclude='.DS_Store' public/assets #{user}@#{application}:#{shared_path}/"
  end
  # cap deploy:assets
end

after 'deploy:update_code', 'deploy:symlink_shared'
