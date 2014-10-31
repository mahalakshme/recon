# This file is used by Rack-based servers to start the application.

begin
  require 'unicorn/oob_gc'
  use Unicorn::OobGC, 1
  puts 'Using Unicorn::OobGC'
rescue; end

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application
