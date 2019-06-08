# Change these
set :repo_url,        'xxxxx'
set :application,     'market'
set :user,            'deploy'

server 'market-rails-01', user: "#{fetch(:user)}", port: 22, roles: [:web, :app, :db], primary: true

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :passenger_roles, :app
set :passenger_restart_runner, :sequence
set :passenger_restart_wait, 5
set :passenger_restart_limit, 2
set :passenger_restart_with_sudo, false
set :passenger_environment_variables, {}
set :passenger_restart_command, 'passenger-config restart-app'
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }
before 'deploy:assets:precompile', 'deploy:migrate'

require "whenever/capistrano"
require "capistrano/rvm"
require "capistrano/deploy"

set :rvm_ruby_version, '2.3.3'
# set :whenever_command, "cd #{fetch(:deploy_to)}/current && bundle exec whenever"
set :whenever_command, [:bundle, :exec, :whenever]

namespace :deploy do
	desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  # after 'deploy:update_code','whenever:update_crontab'
end

namespace :db do
	task :seed do
	 puts "\n=== Seeding Database ===\n"
	 on primary :db do
	  within current_path do
	    with rails_env: fetch(:stage) do
	      execute :rake, 'db:seed'
	    end
	  end
	 end
	end
end

namespace :solr do
	task :reindex do
	 puts "\n=== Reindexing Database ===\n"
	 on primary :db do
	  within current_path do
	    with rails_env: fetch(:stage) do
	      execute :rake, 'sunspot:solr:reindex'
	    end
	  end
	 end
	end
end
