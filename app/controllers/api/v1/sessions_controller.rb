class Api::V1::SessionsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :create]
  respond_to :json
  def create
    @user = User.where(email: params[:email]).first
    if @user&.valid_password?(params[:password])
      render :create, status: :created
    else
      head(:unauthorized)
      render_error
    end
  end

  def destroy
    current_user&.authentication_token = nil
    if current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end
end
