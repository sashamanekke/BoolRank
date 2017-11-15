class PollsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create, :show]
  before_action :set_poll, only: [:show, :add_propositions, :edit, :update, :destroy, :compare, :results, :start]


  def index
    @polls = Poll.all
  end

  def start

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
    # if params[:title]
    @poll = Poll.new(poll_params)
    # else
      # @poll = Poll.new()
    # end
  end

  def add_propositions
    @proposition = Proposition.new()
  end

  def create
    @poll = Poll.new(poll_params)
    # add current user when login is set !!!!!!!!!!!!!!!!
    @poll.user = current_user
    if @poll.save!
      redirect_to add_propositions_poll_path(@poll)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def compare
    #At one point show a button "see result" wich will show back the poll page
    #Which will integrate then the results
    all_combinations = generate_combinations(@poll.propositions)
    #Here need to add the fact to delete the comparisons already done
    # something like existing_combinations = generate_existing_combinations()
    #existing_combinations = generate_combinations(@poll.votes)
    @comparison = all_combinations.sample
  end

  def start

  end

  def results
    @propositions = @poll.propositions.order(:score)
  end

  private
  def set_poll
    @poll = Poll.find(params[:id])
  end
  def poll_params
    params.require(:poll).permit(:title, :description, :photo, :status)
  end

  def generate_combinations(props)
    all_combinations = []
    props.each_with_index do |p1, index|
      props[(index + 1)..-1].each do |p2|
        all_combinations << [p1,p2]
      end
    end
    all_combinations
  end

  def generate_existing_combinations(votes)
    existing_combinations = []

    votes.each_with_index do |p1, index|
      combinaison = [votes.accepted, votes.rejected]
      combinaison.sort!
      existing_combinations << combination
    end
    existing_combinations
  end

end


