class Api::V1::PollsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_poll, only:[:show, :update]

  def index
    @polls = policy_scope(Poll)
  end

  def show
  end

  def update
    if @poll.update(poll_params)
      render :show
    else
      render_error
    end
  end

  def create
    @poll = Poll.new(poll_params)
    @poll.user = current_user
    authorize @poll
    if @poll.save
      render :show
    else
      render_error
    end
  end

  private

  def set_poll
    @poll = Poll.find(params[:id])
    authorize @poll
  end
  def poll_params
    params.require(:poll).permit(:title, :description, :photo, :status)
  end

  def render_error
    render json: { errors: @poll.errors.full_messages },
      status: :unprocessable_entity
  end
end
