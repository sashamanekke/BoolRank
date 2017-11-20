class PropositionsController < ApplicationController
  before_action :set_proposition, only: [:show, :add_propositions, :edit, :update, :destroy]
  before_action :set_poll, only: [:create, :show, :destroy, :edit, :update]
  def index
  end

  def show
    # @proposition.poll = @poll
  end

  def new
    #I think we don't need this one since it is taken care of
    #the polls controller
  end

  def create
    colors = ["#FF0000","#FFFF00","#00FF00","#00FFFF"," #0000FF","#FF00FF"]
    @proposition = Proposition.new(proposition_params)
    @proposition.poll = @poll
    @proposition.color = colors.sample
    if @proposition.save!
      redirect_to add_propositions_poll_path(@poll)
    else
      render add_propositions_poll_path(@poll)
    end
  end

  def edit
  end

  def update
    @proposition.update(params[:proposition])
  end

  def destroy

    if @proposition.destroy
      redirect_to add_propositions_poll_path(@poll)
    else
      render add_propositions_poll_path(@poll)
    end
  end

  private
  def set_proposition
    @proposition = Proposition.find(params[:id])
  end
  def set_poll
    @poll = Poll.find(params[:poll_id])
  end
  def proposition_params
    params.require(:proposition).permit(:name, :score, :photo, :hashtag, :description)
  end
  def poll_params
    params.require(:poll).permit(:title, :description, :photo, :status)
  end
end
