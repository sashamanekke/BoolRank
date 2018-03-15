class PollsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:start, :home_special]
  before_action :set_poll, only: [:show, :add_propositions, :edit, :update, :destroy, :compare, :results, :start, :toggle_closed, :toggle_public_poll, :home_special]


  def index
    @polls = Poll.all
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
    # else
      # @poll = Poll.new()
    # end
  end

  def add_propositions
    @proposition = Proposition.new()
  end

  def create
    poll_colors = (1..16).map{ |i| i < 10 ? "0#{i}.jpg" : "#{i}.jpg" }
    @poll = Poll.new(poll_params)
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
    @remainings = Poll.compute_remaining_combinations(@poll, current_user.id)
    @comparison = @remainings.sample
    @total_score = Poll.compute_total_score(@poll)
    sleep 0.3
  end

  def home_special
    @poll_public = @poll
    if current_user != nil
      @remainings = Poll.compute_remaining_combinations(@poll_public, current_user.id)
      @percentage = Poll.compute_percentage(@poll_public, current_user.id)
    else
      @remainings = Poll.compute_remaining_combinations(@poll_public, session.id)
      @percentage = Poll.compute_percentage(@poll_public, session.id)
    end
    @comparison = @remainings.sample
    @total_score = Poll.compute_total_score(@poll_public)

    #sleep 0.3
  end

  def start
  end

  def results
    #byebug
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
  end
  def poll_params
    params.require(:poll).permit(:title, :description, :photo, :status)
  end

end


