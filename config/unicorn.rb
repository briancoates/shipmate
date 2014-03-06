# Set the working application directory 
working_directory "/opt/apps/shipmate/current" 
# Unicorn PID file location 
pid "/opt/apps/shipmate/pids/unicorn.pid "
# Path to logs 
stderr_path "/opt/apps/shipmate/log/unicorn.log" 
stdout_path "/opt/apps/shipmate/log/unicorn.log" 
# Unicorn socket listen "/tmp/unicorn.[app name].sock" 
listen "/tmp/unicorn.shipmate.sock" 
# Number of processes 
# worker_processes 4 worker_processes 2 
# Time-out timeout 30