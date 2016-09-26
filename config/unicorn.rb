root = '/home/deployer/apps/kitty/current'

working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
listen "#{root}/tmp/sockets/unicorn.sock", backlog: 64

worker_processes 2
timeout 30
#preload_app true


# before_exec do |server|
#   ENV["BUNDLE_GEMFILE"] = "#{rails_root}/Gemfile"
# end
#
# before_fork do |server, worker|
#   # Перед тем, как создать первый рабочий процесс, мастер отсоединяется от базы.
#   defined?(ActiveRecord::Base) and
#   ActiveRecord::Base.connection.disconnect!
# end
#
# after_fork do |server, worker|
#   # После того как рабочий процесс создан, он устанавливает соединение с базой.
#   defined?(ActiveRecord::Base) and
#   ActiveRecord::Base.establish_connection
# end
# use correct Gemfile on restarts
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

# preload
preload_app true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
