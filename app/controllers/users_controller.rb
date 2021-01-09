class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new

  end

  def index
    @user = current_user
    @users = User.all
    @book_new = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
      if @user == current_user
        render "edit"
      else
        redirect_to users_path
      end
    
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id) ,notice: 'You have updated user successfully.'
    else
      render "edit"
    end
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  
end
