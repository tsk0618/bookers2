class UsersController < ApplicationController
  before_action :baria_user, only: [:edit, :destroy, :update]
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new 
  end
  
  def show
    #byebug
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.new
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else 
      render :edit
    end  
  end
  
  private
  
  def user_params 
    params.require(:user).permit(:name,:introduction,:profile_image)
  end  
  
  def baria_user
    unless User.find(params[:id]) == current_user
           redirect_to user_path(User.find(current_user.id))
    end
  end  
end
