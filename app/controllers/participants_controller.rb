class ParticipantsController < ApplicationController
  def index
    @participants = Participant.all
  end

  def create

  end

  def destroy
  end

private

# def set_participants
#   @user = User.find(params[:user_id])
# end

end
