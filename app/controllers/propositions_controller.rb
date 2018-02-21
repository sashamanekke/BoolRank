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
    colors = ["#C3A7F3","#FDAAB0","#FEDF32","#44C7AA","#EE5F5B","#469AE0"]
    # gradient_colors = (1..16).map{ |i| i < 10 ? "0#{i}.jpg" : "#{i}.jpg" }
    @proposition = Proposition.new(proposition_params)
    authorize @proposition
    @proposition.poll = @poll

    used_colors = generate_used_colors(@poll)
    remaining_colors = colors - used_colors
    if remaining_colors == []
      @proposition.color = colors.sample
    else
      @proposition.color = remaining_colors.sample
    end
    if @proposition.save!
      redirect_to add_propositions_poll_path(@poll)
    else
      render add_propositions_poll_path(@poll)
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update

      if @proposition.update(proposition_params)
      redirect_to add_propositions_poll_path(@poll)
    else
      render add_propositions_poll_path(@poll)
    end
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

  def generate_used_colors(poll)
    used_colors = []
    poll.propositions.each do |prop|
      used_colors << prop.color
    end
    used_colors
  end

end
