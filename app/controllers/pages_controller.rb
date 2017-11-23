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
  end
end
