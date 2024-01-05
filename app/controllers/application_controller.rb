class ApplicationController < ActionController::Base
  def not_found
    raise ActionController::RoutingError.new('Nothing to be seen here')
  end
end
