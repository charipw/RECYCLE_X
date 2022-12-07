class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def stats
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to profile_path(@user)
  end


  private

  def user_params
    params.require(:user).permit(:username, :postcode, :email, :borough_id)
  end
end
