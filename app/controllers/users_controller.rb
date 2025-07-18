class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :authenticate_user!  
  def new
    @user=User.new
  end

  def show
    @login_user = current_user
    begin
      @user = User.find(params[:id])
      @books = @user.books
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "ユーザーが見つかりませんでした。"
    end   
    @book = Book.new
  end

  def index
      @login_user = current_user
      @users=User.all
      @book = Book.new
      @user = current_user
  end

  def edit
    is_matching_login_user
    @user=User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
