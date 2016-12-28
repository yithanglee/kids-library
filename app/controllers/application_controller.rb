class ApplicationController < ActionController::Base
  include Clearance::Controller
  config.time_zone = 'Kuala Lumpur'
end
