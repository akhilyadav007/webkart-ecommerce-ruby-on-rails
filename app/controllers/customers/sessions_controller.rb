class Customers::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  private
  def respond_with(current_user, _opts = {})
    jwt_token = generate_jwt_token(current_user)
    render json: {
      status: { 
        code: 200, message: 'Logged in successfully.',
        data: {
          customer: CustomerSerializer.new(current_user).serializable_hash[:data][:attributes].merge(token: jwt_token)
        }
      }
    }, status: :ok
  end

  def generate_jwt_token(user)
    payload = { sub: user.id }
    JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key!)
  end
    
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = Customer.find(jwt_payload['sub'])
    end
    
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
