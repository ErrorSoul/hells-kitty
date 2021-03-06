namespace :deploy do
  desc 'Makes sure local git is in sync with remote.'
  task :check_revision do
    puts "I M WORKING "
    puts "I M WORKING "
    puts "I M WORKING "
    puts "I M WORKING "
    puts "I M WORKING "
    puts "I M WORKING "
    puts "#{ENV}"
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts 'WARNING: HEAD is not the same as origin/master'
      puts 'Run `git push` to sync changes.'
      exit
    end
  end

  %w(start stop restart upgrade).each do |command|
    desc "#{command} Unicorn server."
    task command do
      on roles(:app) do
        puts 'IM WORKING'
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end
  before :deploy, 'deploy:check_revision'

  #after :deploy, 'deploy:start'
  #after :rollback, 'deploy:start'
end
