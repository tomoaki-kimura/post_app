class UsersController < ApplicationController
  before_action :require_user_logged_in, only: %i[ show ]
  before_action :require_admin_logged_in, only: %i[ index ]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :correct_user, only: %i[ edit update destroy ]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @pictures = @user.pictures
    @favorite_pictures = @user.favorite_pictures
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザーを作成しました。"
      redirect_to login_url
    else
      flash.now[:danger] = "ユーザーの作成に失敗しました。"
      render :new
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:success] = "データーを更新しました。"
      redirect_to user_url(@user)
    else
      flash.now[:danger] = "データーの更新に失敗しました。"
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to root_url
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    if current_user != @user && !current_user.admin?
      redirect_to root_url
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end