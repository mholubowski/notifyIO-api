require 'capistrano/ext/puppetize'
require "bundler/capistrano"

EC2_DNS_ADDRESS = "ec2-67-202-41-254.compute-1.amazonaws.com"

set :ssh_private_key, File.expand_path("#{ENV['HOME']}/.ssh/NotifyIO-Keypair.pem")
set :ssh_options,{keys: fetch(:ssh_private_key), forward_agent: true}

set :user, "ubuntu"

set :application, "app"
set :repository,  "git@github.com:mholubowski/notifyIO-api.git"
set :deploy_via, :remote_cache

set :deploy_to, "/home/#{user}/www/#{application}"

set :scm, :git

current_git_branch = `git branch`.match(/\* (\S+)\s/m)[1]

puts "################\nDeploying branch #{current_git_branch}\n################"

set :branch, current_git_branch

set :use_sudo, false

default_run_options[:pty] = true

set :host, "#{user}@#{EC2_DNS_ADDRESS}"
role :web, host
role :app, host


namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && thin -C thin/production_config.yml -R config.ru start"
  end

  task :stop, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && thin -C thin/production_config.yml -R config.ru stop"
  end

  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end

  task :cold do
    deploy.update
    deploy.start
    sudo "service nginx stop"
    sudo "cp #{current_path}/nginx/nginx.conf /etc/nginx/nginx.conf"
    sudo "service nginx start"
  end
end

namespace :mobile do
  task :log do
    run "cat #{deploy_to}/current/log/thin.log"
  end
end
