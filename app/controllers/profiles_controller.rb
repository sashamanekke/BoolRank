class ProfilesController < ApplicationController
    # before_action :set_profile

    def show
      if current_user.profile.nil?
        profile = Profile.new()
        profile.user = current_user
        profile.save
      end
    # @user = User.find(params[:id])

    # @user = @user.reservations
    # @pippo = 1

  end

   def edit
    # @user = User.find(params[:id])

    # @user = @user.reservations
    # @pippo = 1

  end

   def update
    # @user = User.find(params[:id])
    current_user.profile.update(profile_params)

    redirect_to profiles_path(@profile)

  end

 def new
    # @user = User.find(params[:id])
    current_user.profile.update(profile_params)

    redirect_to profiles_path(@profile)
  end

private

  def profile_params
    params.require(:profile).permit(:name, :surname, :photo)
  end

  def set_profile
    @profile = Profile.find(current_user.profile.id)
  end


end

