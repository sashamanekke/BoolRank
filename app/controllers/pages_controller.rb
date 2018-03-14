class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  # layout "landing_page"
  def home
    @magic_8_ball = [
      "It is certain",
      "Without doubt",
      "As I see it",
      "Yes!",
      "Most Likely",
      "Outlook good",
      "Yes",
      "My reply: no",
      "Very doubtful",
      "Reply hazy",
      "Try again",
      "Concentrate",
      "Ask again"


    ]

    @poll = Poll.new()
    #public_polls = Poll.all.select{|poll| poll.status}
    #@poll_public = public_polls.sample

    public_polls = Poll.all.select{|poll| poll.status}
    @poll_public = public_polls.sample
    #end
    @remainings = Poll.compute_remaining_combinations(@poll_public, session.id)
    @comparison = @remainings.sample
    @total_score = Poll.compute_total_score(@poll_public)

    #PollsController.home_special
    #byebug
  end
end
