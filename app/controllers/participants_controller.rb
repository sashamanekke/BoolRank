class ParticipantsController < ApplicationController
  def index
    @poll = Poll.find(params[:poll_id])
  end

  def create
    @poll = Poll.find(params[:poll_id])
    @participant = Participant.new()
    @participant.poll = @poll
    @participant.user = current_user
    @participant.save
    redirect_to compare_poll_path(@poll)
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
