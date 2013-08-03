require '../conf'
version = Site::CONFIG[:ruby_version]

package :ruby do 
  requires :ruby_build, :ruby_gems, :bundler
end

package :ruby_build do 
  requires :ruby_essentials

  file "~/tmp/ruby-install.sh", contents: render("ruby_install.sh")
  runner "chmod u+x ~/tmp/ruby-install.sh"
  runner "~/tmp/ruby-install.sh", sudo: true

  verify { has_executable_with_version "ruby", version.delete("-"), "-v" }
end

package :ruby_essentials do 
  apt "build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev checkinstall libgdbm-dev", sudo: true
end

package :ruby_gems do
  requires :ruby_build
  push_text "gem: --no-ri --no-rdoc", "~/.gemrc"
  runner "gem update --system", sudo: true

  verify { has_file "~/.gemrc" }
end

package :bundler do 
  runner "gem install bundler", sudo: true
  verify { has_executable "bundle" }
end

# gave up on rvm and rbenv, mostly sprinkle's fault for using a weird shell

# package :install_rbenv do
#   requires :git
#   description 'Ruby RBEnv'

#   runner  "git clone git://github.com/sstephenson/rbenv.git ~/.rbenv"
#   runner "git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"

#   push_text 'export PATH="$HOME/.rbenv/bin:$PATH"', "~/.bash_profile"
#   push_text 'eval "$(rbenv init -)"', "~/.bash_profile"

#   verify do
#     has_executable "~/.rbenv/bin/rbenv"
#   end
# end

# package :install_ruby do
#   requires :install_rbenv, :ruby_essentials

#   version = Site::CONFIG[:ruby_version]

#   runner "rbenv install #{version}"
#   runner "rbenv rehash"

#   verify do
#     has_executable "~/.rbenv/shims/ruby"
#   end
# end

# package :rbenv_bundler do
#   requires :use_rbenv

#   runner "gem install bundler"
#   runner "rbenv rehash"

#   verify do 
#     @commands << "gem list | grep bundler"
#   end
# end

# package :use_rbenv do
#   requires :install_ruby, :rbenv_sudo

#   version = Site::CONFIG[:ruby_version]

#   runner "rbenv rehash"
#   runner "sudo rbenv global #{version}", pty: true
#   runner "rbenv rehash"
# end

# package :install_rubygems do
#   requires :use_rbenv

#   description 'Ruby Gems Package Management System'
#   version '1.8.25'

#   source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz" do
#     custom_install "ruby setup.rb"
    
#     # post :install, "ln -s /usr/bin/gem1.8 /usr/bin/gem"
#     post :install, "gem update --system"
#   end

#   verify do
#     has_executable "~/.rbenv/shims/gem"
#   end
# end

# package :install_bundler do
#   requires :use_rbenv
#   requires :install_rubygems

#   runner "gem install bundler --no-rdoc --no-ri"
#   runner "rbenv rehash"
  
#   verify do
#     has_executable "~/.rbenv/shims/bundle"
#   end
# end

# package :ruby_essentials do
#   apt 'libssl-dev zlib1g zlib1g-dev libreadline-dev build-essential', sudo: true
# end

# package :rbenv_sudo do 
#   requires :install_rbenv

#   runner "git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo"

#   verify { has_directory '~/.rbenv/plugins/rbenv-sudo' }
# end

# package :ruby_rbenv, provides: :ruby do
#   requires :ruby_essentials
#   requires :install_rubygems
#   requires :install_bundler
# end