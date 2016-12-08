threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

rackup      DefaultRackup

# specifies the 'port' that Puma will listen on to receive requests (the same as rails default), default is 3000
port        ENV.fetch("PORT")               { 3000 }

# specifies the 'environment' that Puma will run in
environment ENV.fetch("RACK_ENV")           {"development"}

# specifies the number of 'workers' to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max 'threads' * 'workers'.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
workers     ENV.fetch("WEB_CONCIRRENCY")    { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#

preload_app!

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
#
# on_worker_boot do
#   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
# end


# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

on_worker do
    # Worker specific setup for Rails 4.1+
    # See: https:devcenter.heroku.com/articles/deploying-rail-applications-with-the-puma-web-server#on-worker-boot
    ActiveRecord::Base.establish_connection
end


