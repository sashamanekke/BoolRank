class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  # layout "landing_page"
  def home
    @magic_8_ball = [
      "It is certain",
      "It is decidedly so",
      "Without doubt",
      "Yes definitely",
      "You may rely on it",
      "As I see it, yes",
      "Most likely",
      "Outlook good",
      "Yes",
      "Signs point to yes",
      "Reply hazy try again",
      "Ask again later",
      "Better not tell you now",
      "Cannot predict now",
      "Concentrate and ask again",
      "Dont count on it",
      "My reply is no",
      "Very doubtful",
      "My sources say no",
      "Outlook not so good",
      "Very doubtful"
    ]

    @poll = Poll.new()
    #public_polls = Poll.all.select{|poll| poll.status}
    #@poll_public = public_polls.sample

    # IMPORTANT! here we use the 'status' attributeof the poll to show specific polls only
    # on the frontpage! Not the 'public_poll' attribute.
    public_polls = Poll.all.select{|poll| poll.status}
    @poll_public = public_polls.sample
    #end
    if @poll_public == nil
      @poll_public = Poll.find_by_id(1)
    end
    @remainings = Poll.compute_remaining_combinations(@poll_public, session.id)
    @comparison = @remainings.sample
    @total_score = Poll.compute_total_score(@poll_public)
    @percentage = Poll.compute_percentage(@poll_public, session.id)

    #PollsController.home_special
    #byebug
  end
end
