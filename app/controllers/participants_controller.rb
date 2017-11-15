class ParticipantsController < ApplicationController
  def index
    @participants = Participant.all
  end

  def create
    @poll = poll.find(params[:poll_id])
    @participant = Participant.new()
  end

  def destroy
  end

private

# def set_participants
#   @user = User.find(params[:user_id])
# end

def participants_params
  params.require(:participants).permit(:user, :profile)
end

end
