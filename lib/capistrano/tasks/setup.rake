namespace :setup do
  desc 'Upload database.yml file.'
  task :upload_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read('config/database.yml')), "#{shared_path}/config/database.yml"
    end
  end

  desc 'Seed the database.'
  task :seed_db do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'show files in tmp.'
  task :zips do
    on roles(:app) do
      execute "ls -ahl #{current_path}/tmp"
    end
  end

  desc 'Symlinks config files for Nginx and Unicorn.'
  task :symlink_config do
    on roles(:app) do
      execute 'rm -f /etc/nginx/sites-enabled/default'
      execute "rm -f /etc/nginx/sites-enabled/#{fetch(:application)}"
      execute "rm -f /etc/init.d/unicorn_#{fetch(:application)}"
      execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
      execute "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
    end
  end
  before :deploy, 'setup:symlink_config'
end



namespace :logs do
  desc "tail rails logs"
  task :tail_rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end
  desc "tail unicorn logs"
  task :unicorn do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/unicorn.log"
    end
  end
end
