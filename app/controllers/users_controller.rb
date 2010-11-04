class UsersController < ApplicationController
  
  before_filter :require_no_user

  def register
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save 
      flash[:notice] = "Registration Successful"
      redirect_to root_path
    else
      render :register
    end
  end

end
