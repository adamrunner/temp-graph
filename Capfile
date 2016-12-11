# Standard Capistrano requirements for a passenger/rbenv/rails application
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/passenger'
# Explicitly require git support for Capistrano
require 'capistrano/scm/git'

install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
