class ProfilesController < ApplicationController
  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

private

  def profile_params
    params.require(:profile).permit(:name, :surname, :photo)
  end

end

