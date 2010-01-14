set :application, "mobile"
set :repository,  "git://github.com/hcatlin/wikimedia-mobile.git"

set :scm, :git
set :user, "deploy"
set :deploy_to, "/srv/#{application}"
set :branch, "stable"

role :web, "mobile1.wikimedia.org", "mobile2.wikimedia.org"
role :cache, "mobile1.wikimedia.org"

namespace :deploy do
  
  task :gems do
    run "cd #{current_path} && gem bundle"
  end
  
  task :restart do
    run "#{current_path}/bin/server --onebyone -C #{current_path}/config/thins/mobile.yml restart"
  end
  
  task :start do
    begin
      run "#{current_path}/bin/cluster start"
    rescue
      retry
    end
  end
  
  task :stop do
    begin
      run "#{current_path}/bin/cluster stop"
    rescue
    end
  end
end