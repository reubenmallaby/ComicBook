class ApplicationController < ActionController::Base

  def known_tags
    ActsAsTaggableOn::Tag.all.order(name: :asc)
  end

  def not_found
    raise ActionController::RoutingError.new('Nothing to be seen here')
  end
end
