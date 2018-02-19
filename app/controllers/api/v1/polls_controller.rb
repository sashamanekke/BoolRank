class Api::V1::PollsController < Api::V1::BaseController
  def index
    @polls = policy_scope(Poll)
  end
  def show
    @poll = Poll.find(params[:id])
    authorize @poll
  end
end
