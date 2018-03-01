class Api::V1::BaseController < ActionController::Base
  acts_as_token_authentication_handler_for User, except: [ :index, :show]
  # before_action :authenticate_user! <<<< don't need this one, replaced by the one just above
  after_action :verify_authorized, except: :index

  rescue_from StandardError,                with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def internal_server_error(exception)
    if Rails.env.development?
      response = { type: exception.class.to_s, error: exception.message }
    else
      response = { error: "Internal Server Error" }
    end
  end
end
