class PollsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create, :show]
  before_action :set_poll, only: [:show, :edit, :update, :start, :destroy]

  def index
    @polls = Poll.all
  end

  def show
    @propositions = @poll.propositions.order(:score)

    #Ranking is done here! (in the view) show the ranking
    #Only if there are enough votes AND that the user
    #has voted enough
    #Start is done here! (in the view)
    #Share poll option here! (in the view)
    #Share ranking option here! (in the view)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def compare
    # At one point show a button "see result" wich will show back the poll page
    # Which will integrate then the results
    # assign vote to selected prop
    # created vote should redirect to next proposition
    # if all propositions are finished, redirect to results page
  end

  def start
  end

  private
  def set_poll
    @poll = Poll.find(params[:id])
  end
  def poll_params
    params.require(:poll).permit(:title, :description, :status, :price, :photo)
  end
end


