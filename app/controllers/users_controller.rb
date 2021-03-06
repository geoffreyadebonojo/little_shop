class UsersController < ApplicationController

  def new
    if session[:user]
      session[:user][:email] = nil
      @user = User.new(session[:user])
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'You are now registered and logged in'
      redirect_to profile_path
    else
      session[:user] = @user
      flash[:error] = 'Email Address already exists'
      redirect_to new_user_path
    end
  end

  def edit
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = 'Your Info Was Successfully Updated!'
      if current_admin?
        redirect_to merchant_path(@user) if @user.role == "merchant_user"
        redirect_to admin_user_path(@user) if @user.role == "registered_user"
      else
        redirect_to profile_path
      end
    else
      render :edit
    end
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :address,
      :city,
      :state,
      :zip_code,
      :password,
      :password_confirmation,
      :email
    )
  end
end
