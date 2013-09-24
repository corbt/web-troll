server 						Site::CONFIG[:server], :app, :web, :db, primary: true
set :deploy_to,		Site::CONFIG[:app_dir]+"/site"
set :branch,			"master"
role :resque_worker, Site::CONFIG[:server]