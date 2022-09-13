class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

   def after_sign_out_path_for(resource)
      root_path
   end

   def not_found
      raise ActionController::RoutingError.new('Not Found')
   rescue
      render_404
   end

   def render_404
      render file: "#{Rails.root}/public/404.html", status: :not_found
   end
   
   protected
   def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :username, :email, :password, :password_confirmation, :remember_me, :current_password)}
   end
end
