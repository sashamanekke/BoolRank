class VotesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  def create
    set_poll
    accepted_proposition = Proposition.find(params[:accepted])
    rejected_proposition = Proposition.find(params[:rejected])
    @vote = Vote.new()
    @vote.poll = @poll
    @vote.accepted_proposition = accepted_proposition
    @vote.rejected_proposition = rejected_proposition
    if current_user != nil
      @vote.user = current_user
      @vote.session_user_id = current_user.id
    else
      @vote.user = User.find_by_id(1)
      @vote.session_user_id = session.id
    end
    # add 1 to the score of the accepted proposition
    accepted_proposition.score += 1
    accepted_proposition.save!
    #byebug
    if @vote.save!
      respond_to do |format|
        format.html {redirect_to compare_poll_path(@poll)}
        format.js {redirect_to home_special_poll_path(@poll)} #<< Work here to handle the ajax call
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js {redirect_to home_special_poll_path(@poll)} # <-- idem
      end
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
