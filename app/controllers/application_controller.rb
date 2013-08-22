# encoding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include PublicActivity::StoreController

 #helper_method :current_admin, :current_seller, :current_buyer
               # :require_admin!, :require_seller!, :require_buyer!

  def account_url
    return new_user_session_url unless user_signed_in?
    case current_user.class.name
      when "Admin"
        activities_path
      when "Client"
        client_path(current_user)
      when "Operator"
        trips_path
      else
        root_url
    end if user_signed_in?
  end

  def after_sign_in_path_for(resource)
   #user_path(resource)
    #stored_location_for(resource) || 
      account_url
    #
        #clients_path(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => "Доступ запрещен"
  end
end
