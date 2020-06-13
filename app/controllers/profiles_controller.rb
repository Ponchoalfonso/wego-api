class ProfilesController < ApplicationController
  before_action :application_only
  skip_before_action :admin_only

  def show
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      render :show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:profile).permit(:name, :last_name, :second_last_name, :birthday, :phone_number, :profile_picture)
  end
end
