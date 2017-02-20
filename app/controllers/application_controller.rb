class ApplicationController < ActionController::Base
  include Clearance::Controller
  config.time_zone = 'Kuala Lumpur'

	before_filter :set_user_language

def set_user_language
  I18n.locale = "cn"
end



end
