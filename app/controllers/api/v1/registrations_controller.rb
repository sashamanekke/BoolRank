class Api::V1::RegistrationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :create]
  respond_to :json
  def create
    @user = User.new(email: params[:email], password: params[:password])
    if @user.save!
      render :create, :status=>201
      return
    else
      render :json=> user.errors, :status=>422
    end
  end
end
