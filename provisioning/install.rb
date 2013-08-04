require '../conf'
Dir["./packages/*.rb"].each {|file| require file }

policy :stack, :roles => :app do 
  requires :git
  requires :utils
  requires :ruby
  requires :server
  requires :appserver
  requires :database
  requires :nodejs
  requires :redis
end

policy :wtroll, :roles => :app do
	requires :java
	# requires :troll
end

deployment do
  delivery :capistrano do 
    role :app, Site::CONFIG[:server]
    set :user, "deploy"
    logger.level = Capistrano::Logger::TRACE
    default_run_options[:pty] = true
  end
end

# Provisioning must:
#   install redis-server
#   install mysql
#   install rvmc/ruby 2.0.0
#   install/configure nginx (unicorn)
#   install jre

#   copy relevant db dumps
#   create/assign /data/apps

# Deploy must:
#   rsync troll app files
#   git trollie app files

#   rake resque:restart_workers
#   rake secrets:generate
#   rake db:migrate

#   rake assets:precompile