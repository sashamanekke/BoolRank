class Api::V1::VotesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show]
  before_action :set_poll, only:[:show, :create, :update, :destroy]

 def create
    set_poll
    accepted_proposition = Proposition.find(vote_params[:accepted_proposition_id])
    rejected_proposition = Proposition.find(vote_params[:rejected_proposition_id])

    @vote = Vote.new()

    # next line is NOT true, it should be current_user but I run into an error if this is the case
    @vote.user = current_user
    @vote.poll = @poll
    @vote.accepted_proposition = accepted_proposition
    @vote.rejected_proposition = rejected_proposition
    # add 1 to the score of the accepted proposition
    accepted_proposition.score += 1
    accepted_proposition.save!
    if @vote.save!
      render :show, status: :created
    else
      render_error
    end
  end

  # def destroy
  #   @vote.destroy
  #   head :no_content
  # end

  private

  def set_poll
    @poll = Proposition.find(vote_params[:accepted_proposition_id]).poll
  end
  def vote_params
    params.permit(:accepted_proposition_id, :rejected_proposition_id)
  end

  def render_error
    render json: { errors: @vote.errors.full_messages },
      status: :unprocessable_entity
  end

end
