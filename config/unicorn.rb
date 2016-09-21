root = '/home/deployer/apps/kitty/current'

working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
old_pid = "#{pid}.oldbin"
listen "#{root}/tmp/sockets/unicorn.sock", backlog: 64

worker_processes 2
timeout 30
preload_app true
