class Api::V1::PollsController < Api::V1::BaseController
  before_action :set_poll, only:[:show, :update, :destroy]
  acts_as_token_authentication_handler_for User, except: [ :index, :show]
  def index
    @polls = Poll.all
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
    if @poll.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @poll.destroy
    head :no_content
  end

  def compare
    @all_combinations = generate_combinations(@poll.propositions)
  end

  private

  def set_poll
    @poll = Poll.find(params[:id])
  end
  def poll_params
    params.require(:poll).permit(:title, :description, :photo, :status)
  end

  def render_error
    render json: { errors: @poll.errors.full_messages },
      status: :unprocessable_entity
  end

  def generate_combinations(props)
    props = props.sort { |a, b|  a.id <=> b.id }
    all_combinations = []
    props.each_with_index do |p1, index|
      props[(index + 1)..-1].each do |p2|
        all_combinations << [p1,p2].sort! { |a, b|  a.id <=> b.id }
      end
    end
    all_combinations
  end

end
