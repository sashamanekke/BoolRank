class PollsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create, :show]
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

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
    # if params[:title]
      @poll = Poll.new(poll_params)
    # else
      # @poll = Poll.new()
    # end
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
    #At one point show a button "see result" wich will show back the poll page
    #Which will integrate then the results
  end

  private
  def set_poll
    @poll = Poll.find(params[:id])
  end
  def poll_params
    params.require(:poll).permit(:title, :description, :status, :price, :photo)
  end
end

# POLLS SCHEMA
  # create_table "polls", force: :cascade do |t|
  #   t.string "title"
  #   t.text "description"
  #   t.string "photo"
  #   t.boolean "status"
  #   t.bigint "user_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["user_id"], name: "index_polls_on_user_id"
  # end


  #  create_table "votes", force: :cascade do |t|
  #   t.bigint "poll_id"
  #   t.bigint "user_id"
  #   t.bigint "accepted_proposition_id"
  #   t.bigint "rejected_proposition_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["accepted_proposition_id"], name: "index_votes_on_accepted_proposition_id"
  #   t.index ["poll_id"], name: "index_votes_on_poll_id"
  #   t.index ["rejected_proposition_id"], name: "index_votes_on_rejected_proposition_id"
  #   t.index ["user_id"], name: "index_votes_on_user_id"
  # end
