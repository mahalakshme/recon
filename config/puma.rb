workers Integer(ENV['MIN_WORKERS'] || 2)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 8)

rackup      DefaultRackup
port        ENV['PORT'] || 3000
environment ENV['RAILS_ENV'] || 'production'
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
