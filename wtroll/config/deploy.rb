require '../conf'
require 'capistrano/ext/multistage'
require 'capistrano-unicorn'
require 'bundler/capistrano'
require 'cape'

Dir[File.join(File.dirname(__FILE__),"deploy","recipes","**","*.rb")].each{ |f| require f }


set :application, 	"corbt"
set :repository,  	Site::CONFIG[:repository]
set :scm,						:git

set :deploy_subdir, "/wtroll"
set :strategy,      RemoteCacheSubdir.new(self)


set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true 
set :deploy_via, :remote_cache

set :user,				"deploy"

set :stages,			 ["production"]
set :default_stage, "production"

set :use_sudo, false

namespace :deploy do
  namespace :assets do
    task :precompile, :except => { :no_release => true } do
      run <<-CMD.compact
        cd -- #{latest_release.shellescape} &&
        #{rake} RAILS_ENV=#{rails_env.to_s.shellescape} assets:precompile
      CMD
    end
  end
end

Cape do
	mirror_rake_tasks :secrets
end

after 'deploy:restart', 'unicorn:reload', 'deploy:assets:precompile', 'secrets:generate'