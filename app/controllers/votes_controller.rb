class VotesController < ApplicationController
  def create
    set_poll
    accepted_proposition = Proposition.find(params[:accepted])
    rejected_proposition = Proposition.find(params[:rejected])
    @vote = Vote.new()
    @vote.poll = @poll
    @vote.accepted_proposition = accepted_proposition
    @vote.rejected_proposition = rejected_proposition
    @vote.user = current_user
    # add 1 to the score of the accepted proposition
    accepted_proposition.score += 1
    accepted_proposition.save!
    if @vote.save!
      redirect_to compare_poll_path(@poll)
    else
      render :new
    end
  end

  private
  def set_poll
    @poll = Poll.find(params[:poll_id])
  end
  def poll_params
    params.require(:poll).permit(:title, :description, :photo, :status)
  end
  def comparison_params
    # params.require(:poll)(comparison: [])
  end
end
