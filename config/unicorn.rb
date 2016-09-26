root = '/home/deployer/apps/kitty/current'

working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
listen "#{root}/tmp/sockets/unicorn.sock", backlog: 64

worker_processes 2
timeout 30
#preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{root}/Gemfile"
end

before_fork do |server, worker|
  # Перед тем, как создать первый рабочий процесс, мастер отсоединяется от базы.
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # После того как рабочий процесс создан, он устанавливает соединение с базой.
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end
