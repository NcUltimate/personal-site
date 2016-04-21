class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :active_class

  def active_class
    @active = Hash.new { '' }
    @active[params[:action].to_sym] = 'active'
  end
end
