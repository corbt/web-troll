require '../conf'
require 'io/console'

password = ""
STDIN.noecho do
  print "Deploy user password: "
  password = gets.chomp
end

package :create_user do
  runner "useradd deploy -s /bin/bash -m -d /home/deploy", sudo: true
  runner "echo \"deploy:#{password}\" | chpasswd", sudo: true
  runner "echo \"deploy ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers", sudo: true
  runner "apt-get update", sudo: true

  verify { has_user "deploy" }
end

policy :bootstrap, :roles => :app do 
  requires :create_user
end

deployment do
  delivery :capistrano do 
    default_run_options[:pty] = true
    role :app, Site::CONFIG[:server]
    set :user, "kyle"
    logger.level = Capistrano::Logger::TRACE
  end
end