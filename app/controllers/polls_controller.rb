class PollsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:start]
  before_action :set_poll, only: [:show, :add_propositions, :edit, :update, :destroy, :compare, :results, :start, :toggle_closed, :toggle_public_poll]


  def index
    @polls = Poll.all
    @polls = policy_scope(Poll)
  end

  def start

  end

  def show
    @propositions = @poll.propositions.order(:score).reverse
    @total_score = 0
    @prop_lenth = @poll.propositions.length
    @poll.propositions.each do |prop|
      @total_score += prop.score
    end
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
    authorize @poll
    # else
      # @poll = Poll.new()
    # end
  end

  def add_propositions
    @proposition = Proposition.new()
    authorize @proposition
  end

  def create
    poll_colors = (1..16).map{ |i| i < 10 ? "0#{i}.jpg" : "#{i}.jpg" }
    @poll = Poll.new(poll_params)
    authorize @poll
    # add current user when login is set !!!!!!!!!!!!!!!!
    @poll.user = current_user
    @poll.closed = false
    @poll.public_poll = false
    @poll.photo = poll_colors.sample
    if @poll.save
      # create a participant automatically when you create a poll
      participant = Participant.new()
      participant.user = current_user
      participant.poll = @poll
      participant.save
      # redirect_to
      redirect_to add_propositions_poll_path(@poll)
    else
      render 'pages/home'
    end
  end

  def edit
  end

  def update
    @poll.title = params[:poll][:title]
    if @poll.save
      redirect_to add_propositions_poll_path(@poll)
    else
      render :new
    end
  end

  def destroy
    @poll.destroy
  end

  def compare
    #generate the basic combinations => [1,2] [3,4] [5,6] ..."
    first_combinations = generate_first_combinations(@poll.propositions)
    #generate all the combinations already voted by the current user
    existing_combinations = generate_existing_combinations(@poll.votes.where(user: current_user))
    #compute the remaining combinations
    remaining_combinations = (first_combinations - existing_combinations)
    @remainings = remaining_combinations
      #generate all the combinations possible
      all_combinations = generate_combinations(@poll.propositions)
    if remaining_combinations == []
      remaining_combinations = (all_combinations - existing_combinations)
    end
    @comparison = remaining_combinations.sample

    @total_score = 0
    @prop_lenth = @poll.propositions.length
    @poll.propositions.each do |prop|
      @total_score += prop.score
    end
    sleep 0.3

    # ### Just to test and see ###
    # @test_array_all = all_combinations.map{ |el|
    #   [el.first.id, el.last.id]
    # }
    # @test_array = first_combinations.map{ |el|
    #   [el.first.id, el.last.id]
    # }
    # @test_array_2 = existing_combinations.map{ |el|
    #   [el.first.id, el.last.id]
    # }
    # # @test_array_3 = @poll.votes.where(user: current_user).map{ |el|
    # #   [el.accepted_proposition.id, el.rejected_proposition.id]
    # # }
    # @test_array_4 = @remainings.map{ |el|
    #   [el.first.id, el.last.id]
    # }
    # ### end ###
  end

  def start
  end

  def results
    @propositions = @poll.propositions.order(:score).reverse
  end

  def toggle_closed
    if @poll.closed == false
      p "TRUE"
      @poll.update_attributes(closed: true)
    else
      @poll.update_attributes(closed: false)
      p "FALSE"
    end
  end

  def toggle_public_poll
    if @poll.public_poll == false
      p "TRUE"
      @poll.update_attributes(public_poll: true)
    else
      @poll.update_attributes(public_poll: false)
      p "FALSE"
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

  def generate_existing_combinations(votes)

    existing_combinations = []
    votes.each do |vote|
      combination = [vote.accepted_proposition, vote.rejected_proposition]
      combination.sort! { |a, b|  a.id <=> b.id }
      existing_combinations << combination
    end
    existing_combinations
  end

  def generate_first_combinations(props)
    props = props.sort { |a, b|  a.id <=> b.id }
    first_combinations = []
    props.each_slice(2) do |slice|
      if props.length.odd? && slice.first == props.last
        slice << props.first
      end
      slice.sort! { |a, b|  a.id <=> b.id }
      first_combinations << slice
    end
    first_combinations.sort!
  end

end


