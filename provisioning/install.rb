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