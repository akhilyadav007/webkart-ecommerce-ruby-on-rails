class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?
    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email address contact is_admin])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name email address contact is_admin])
    end

    def authenticate_customer
     
      if request.headers['Authorization'].present?
#  debugger
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
        current_customer = Customer.find(jwt_payload['sub'])
        
      end

    end
  
end
